//
//  ViewController.m
//  02_KVC00
//
//  Created by Daiyi on 2021/3/28.
//

#import "ViewController.h"
#import "DYPerson.h"
#import "DYPerson2.h"
#import <objc/runtime.h>
#import "DYPerson3.h"
#import "DYContainer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    DYPerson *p = [DYPerson new];
//    [p setValue:@"Tom" forKeyPath:@"dog.name"];
//    NSLog(@"%@", [p valueForKeyPath:@"dog.name"]);
   
//    DYPerson3 *p = [DYPerson3 new];
//
//    [p setValue:nil forKey:@"name"];
//    [p setValue:nil forKey:@"age"];
//
//    [p setValue:@"tome" forKey:@"name1"];
//
//    [p valueForKey:@"agew"];
    
    DYContainer *container = [DYContainer new];
    [container setValue:@"Tom" forKey:@"name"];
    [container setValue:@18 forKey:@"age"];
    
    NSLog(@"name = %@, age = %@", [container valueForKey:@"name"], [container valueForKey:@"age"]);
    
    DYPerson3 *p = [DYPerson3 new];
    p.age = -1;
    NSLog(@"%d", p.age);
}

- (void)demo01 {
    DYPerson2 *p = [DYPerson2 new];
    
//    [p setValue:@"Tom" forKey:@"_name"];
//    [p setValue:@"Tom" forKey:@"name"];
    NSLog(@"name = %@", [p valueForKey:@"name"]);
    
    NSLog(@"name = %@", p->name);
    NSLog(@"_name = %@", p->_name);
    NSLog(@"isName = %@", p->isName);
    NSLog(@"_isName = %@", p->_isName);
}

- (void)demo00 {
    DYPerson *p = [DYPerson new];
    [p setValue:@"Tom" forKey:@"name"];
//    p->_name = @"Tom";
    NSLog(@"%@", [p valueForKey:@"name"]);
    
//    [self.textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.textField.placeholder = @"请填写";
    Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(self.textField, ivar);
    placeholderLabel.textColor = [UIColor redColor];
}

@end
