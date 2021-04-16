//
//  ViewController.swift
//  001_DemoSwift
//
//  Created by Daiyi on 2021/4/15.
//

import UIKit
import GPUImage

class ViewController: UIViewController {
    
    private var vCamera: GPUImageVideoCamera?
    private lazy var mCamera: GPUImageStillCamera = GPUImageStillCamera
    private var mFilter: GPUImageSaturationFilter?
    private var mImageView: GPUImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        _mCamera = GPUImageStillCamera()
        
    }


}

