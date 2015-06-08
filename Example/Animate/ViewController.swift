//
//  ViewController.swift
//  Animate
//
//  Created by CodeEagle on 06/04/2015.
//  Copyright (c) 06/04/2015 CodeEagle. All rights reserved.
//

import UIKit
import pop
import Animate
class ViewController: UIViewController {

    var testView: UIView! = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        testView.backgroundColor = UIColor.orangeColor()
        testView.spring.springBounciness = 20
        testView.spring.springSpeed = 20
        self.view.addSubview(testView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        var view:UIView! = UIView(frame: CGRectMake(10, 10, 50, 50))
//        view.backgroundColor = UIColor.orangeColor()
//        self.view.addSubview(view)
        /*
        .spring({ (make) -> Void in
        make.backgroundColor = UIColor.orangeColor()
        make.center = CGPointMake(200, 300)
        }).delay(1)
        .decay({ (make) -> Void in
        make.velocity(NSValue(CGPoint:CGPointMake(150, 150)),forProperty:kPOPViewCenter)
        make.velocity(NSValue(CGRect:CGRectMake(0, 0, 200, 200)),forProperty:kPOPViewBounds)
        }).delay(1)
        
        */
//        view.basic { (make) -> Void in
//            make.backgroundColor = UIColor.grayColor()
//            make.center = CGPointMake(200, 200)
//            }.delay(1)
//            .spring({ (make) -> Void in
//                make.backgroundColor = UIColor.orangeColor()
//                make.center = CGPointMake(200, 300)
//            }).decay({ (make) -> Void in
//                make.velocity(NSValue(CGPoint:CGPointMake(150, 150)),forProperty:kPOPViewCenter)
//                make.velocity(NSValue(CGRect:CGRectMake(0, 0, 200, 200)),forProperty:kPOPViewBounds)
//            }).delay(1)
//            .done { () -> Void in
//                view.removeFromSuperview()
//                view = nil
//        }
        
        
            self.testView.spring.frame = CGRectMake(20, 120, 200, 200)
//            self.testView.springer.frame = CGRectMake(220, 10, 100, 300)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                self.testView.spring.frame = CGRectMake(220, 10, 100, 300)
            }
        
        
        
    }

}

