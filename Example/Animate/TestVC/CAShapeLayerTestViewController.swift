//
//  CAShapeLayerTestViewController.swift
//  Animate
//
//  Created by LawLincoln on 15/6/8.
//  Copyright (c) 2015年 CocoaPods. All rights reserved.
//

import UIKit
import pop
class CAShapeLayerTestViewController: UIViewController {

    lazy var shape:CAShapeLayer! = {
        let size = self.view.bounds.size
        let sp = CAShapeLayer()
        let path = UIBezierPath(roundedRect: CGRectMake(size.width/4, 100, size.width/2, size.width/2), cornerRadius: size.width/4)
        sp.path = path.CGPath
        sp.strokeStart = 0
        sp.strokeColor = UIColor.orangeColor().CGColor
        sp.fillColor = UIColor.clearColor().CGColor
        return sp
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        animation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    func animation(){
//        self.shape.removeFromSuperlayer()
//        self.view.layer.addSublayer(self.shape)
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
//            self.shape.springs { (make) -> Void in
//                make.fillColor = UIColor.cyanColor()
//                }.delay(0.5)
//                .springs { (make) -> Void in
//                    make.fillColor = UIColor.clearColor()
//                    make.strokeEnd = 0.9
//                    make.springBounciness = 20
//                    make.springSpeed = 20
//                }.delay(0.5)
//                .springs { (make) -> Void in
//                    make.strokeStart = 0.7
//                    make.springBounciness = 20
//                    make.springSpeed = 20
//                    make.strokeColor = UIColor.darkGrayColor()
//                }.delay(0.5)
//                .basics{ (make) -> Void in
//                    make.strokeEnd = 0.7
//                    make.strokeStart = 0.5
//                    make.strokeColor = UIColor.blueColor()
//                }.delay(0.5)
//                .springs{ (make) -> Void in
//                    make.strokeEnd = 0.1
//                    make.strokeStart = -0.1
//                    make.strokeColor = UIColor.redColor()
//                }
//                .springs{ (make) -> Void in
//                    make.strokeStart = 0.2
//                    make.strokeEnd = 0.6
//                    make.strokeColor = UIColor.greenColor()
//                }.spring{ (make) -> Void in
//                    make.bounds = CGRectMake(0, 0, 200, 200)
//                }
//        }
//    }

}
