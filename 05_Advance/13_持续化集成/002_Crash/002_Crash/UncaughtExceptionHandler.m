//
//  UncaughtExceptionHandler.m
//  002---Crash分析
//
//  Created by Cooci on 2018/8/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//


#import "UncaughtExceptionHandler.h"
#import <UIKit/UIKit.h>
#include <libkern/OSAtomic.h>
#include <execinfo.h>

NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";
NSString * const UncaughtExceptionHandlerFileKey = @"UncaughtExceptionHandlerFileKey";
NSString * const UncaughtExceptionHandlerCallStackSymbolsKey = @"UncaughtExceptionHandlerCallStackSymbolsKey";
NSString * const UncaughtExceptionHandlerCallStackReturnAddressesKey = @"UncaughtExceptionHandlerCallStackReturnAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 10;
const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;

void MySignalHandler(int signal);


@implementation UncaughtExceptionHandler

static  UncaughtExceptionHandler *handler = nil;

+ (void) InstallUncaughtExceptionHandler
{
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandlers);

    signal(SIGABRT, MySignalHandler);
    signal(SIGILL, MySignalHandler);
    signal(SIGFPE, MySignalHandler);
    signal(SIGBUS, MySignalHandler);
    signal(SIGPIPE, MySignalHandler);

}

//获取函数堆栈信息
+ (NSArray *)backtrace
{
    
    void* callstack[128];
    int frames = backtrace(callstack, 128);//用于获取当前线程的函数调用堆栈，返回实际获取的指针个数
    char **strs = backtrace_symbols(callstack, frames);//从backtrace函数获取的信息转化为一个字符串数组
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = UncaughtExceptionHandlerSkipAddressCount;
         i < UncaughtExceptionHandlerSkipAddressCount+UncaughtExceptionHandlerReportAddressCount;
         i++)
    {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}

//存储log
- (void)saveCreash:(NSException *)exception file:(NSString *)file
{
    NSArray *stackArray = [exception.userInfo objectForKey:UncaughtExceptionHandlerCallStackSymbolsKey];// 异常的堆栈信息
    NSString *reason = [exception reason];// 出现异常的原因
    NSString *name = [exception name];// 异常名称
    
    //或者直接用代码，输入这个崩溃信息，以便在console中进一步分析错误原因
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    
    
    NSString * _libPath  = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:file];
    
    //    NSString *_libPath=[NSHomeDirectory() stringByAppendingPathComponent:file];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_libPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:_libPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    NSString * savePath = [_libPath stringByAppendingFormat:@"/error%@.log",timeString];
    
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    
    BOOL sucess = [exceptionInfo writeToFile:savePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"保存崩溃日志 sucess:%d,%@",sucess,savePath);
}

//异常处理方法
- (void)handleException:(NSException *)exception
{
    
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFArrayRef  allModes = CFRunLoopCopyAllModes(runloop);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:exception.name preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self->dismissed = true;
    }]];
    [UIApplication.sharedApplication.windows.firstObject.rootViewController presentViewController:alert animated:true completion:nil];
    alert = nil;
//
    
    
    while (!dismissed) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
    
    CFRelease(allModes);
    
    
    NSDictionary *userInfo = [exception userInfo];
    [self saveCreash:exception file:[userInfo objectForKey:UncaughtExceptionHandlerFileKey]];
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName])
    {
        kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
    }else{
        [exception raise];
    }
}


#pragma mark -

//获取应用信息
NSString* getAppInfo()
{
    NSString *appInfo = [NSString stringWithFormat:@"App : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@\n",
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                         [UIDevice currentDevice].model,
                         [UIDevice currentDevice].systemName,
                         [UIDevice currentDevice].systemVersion];
    //                         [UIDevice currentDevice].uniqueIdentifier];
    NSLog(@"Crash!!!! %@", appInfo);
    return appInfo;
}

//NSSetUncaughtExceptionHandler捕获异常的调用方法
//利用 NSSetUncaughtExceptionHandler，当程序异常退出的时候，可以先进行处理，然后做一些自定义的动作
void UncaughtExceptionHandlers(NSException *exception) {
    
    NSArray *callStack = [UncaughtExceptionHandler backtrace];
    NSMutableDictionary *userInfo =
    [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
    [userInfo setObject:@"OCCrash" forKey:UncaughtExceptionHandlerFileKey];
    [userInfo setObject:exception.callStackSymbols forKey:UncaughtExceptionHandlerCallStackSymbolsKey];
    [userInfo setObject:exception.callStackReturnAddresses forKey:UncaughtExceptionHandlerCallStackReturnAddressesKey];
    
    NSException *customException = [NSException
                                    exceptionWithName:[exception name]
                                    reason:[exception reason]
                                    userInfo:userInfo];
    [[[UncaughtExceptionHandler alloc] init] performSelectorOnMainThread:@selector(handleException:)
     withObject: customException
     waitUntilDone:YES];
    
}

//Signal处理方法
void MySignalHandler(int signal)
{
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey];
    NSArray *callStack = [UncaughtExceptionHandler backtrace];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
    [userInfo setObject:@"SigCrash" forKey:UncaughtExceptionHandlerFileKey];
    
    [[[UncaughtExceptionHandler alloc] init]
     performSelectorOnMainThread:@selector(handleException:) withObject:
     [NSException exceptionWithName:UncaughtExceptionHandlerSignalExceptionName reason: [NSString stringWithFormat:NSLocalizedString(@"Signal %d was raised.\n"
                                                                                                                                     @"%@", nil),
                                                                                         signal, getAppInfo()] userInfo:userInfo]
     waitUntilDone:YES];
}



@end
