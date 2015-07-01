//
//  UIViewTestViewController.swift
//  Animate
//
//  Created by LawLincoln on 15/6/8.
//  Copyright (c) 2015年 CocoaPods. All rights reserved.
//

import UIKit
import pop
import Animate
class UIViewTestViewController: TestTemplateViewController {

    private var currentProperty: Int = 0 {
        didSet{
            animateCombine()
        }
    }
    private var currentStyle: Int = 0 {
        didSet{
            animateCombine()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.testView
                .spring { (make) -> Void in
                    make.springBounciness = 20
                    make.springSpeed = 20
                    make.frame = CGRectMake(120, 150, 200, 400)
            }.delay(0.5).decay { (make) -> Void in
                make.velocity(UIColor.greenColor(), forProperty: kPOPViewBackgroundColor)
            }.delay(0.5).basic { (make) -> Void in
                make.frame = CGRectMake(self.view.bounds.size.width/2 - 50, 64 + 80, 100, 100)
            }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "View"
        self.dataList = [
            "Alpha":0.1,
            "BackgroundColor":UIColor.greenColor(),
            "Bounds":NSValue(CGRect: CGRectMake(0, 0, 200, 200)),
            "Center":NSValue(CGPoint: CGPointMake(60, 120)),
            "Frame":NSValue(CGRect: CGRectMake(60, 100, 80, 200)),
            "ScaleX":1.2,
            "ScaleXY":NSValue(CGSize:CGSizeMake(0.5, 1.5)),
            "ScaleY":1.7,
            "Size":NSValue(CGSize:CGSizeMake(80, 80)),
            "TintColor":UIColor.redColor()]
        self.velocityList = [
            "Alpha":-1.8,
            "BackgroundColor":UIColor.yellowColor(),
            "Bounds":NSValue(CGRect: CGRectMake(0, 0, 500, 200)),
            "Center":NSValue(CGPoint: CGPointMake(100, 120)),
            "Frame":NSValue(CGRect: CGRectMake(20, 200, 10, 200)),
            "ScaleX":1.2,
            "ScaleXY":NSValue(CGSize:CGSizeMake(1.5, 2.5)),
            "ScaleY":1.7,
            "Size":NSValue(CGSize:CGSizeMake(100, 80)),
            "TintColor":UIColor.cyanColor()
        ]
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func animateCombine(){
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.testView.alpha = 0
        }) { (b) -> Void in
            if b {
                self.testView.removeFromSuperview()
                self.testView = nil
                self.view.addSubview(self.testView)
                self.Animate()
            }
        }
    }
    
    func Animate(){
        let animator = currentStyle == 0 ? self.testView.spring : (currentStyle == 1 ? self.testView.decay : self.testView.basic)
        
        let v: AnyObject = self.velocityList.values.array[currentProperty]
        
        self.testView.spring.springBounciness = 20
        self.testView.spring.springSpeed = 20
        self.testView.spring.velocity = v
        
        self.testView.basic.timingFunction = CAMediaTimingFunction.easeIn()
        
        self.testView.decay.velocity = v
        let value: AnyObject! = self.dataList.values.array[currentProperty]
        let key = self.dataList.keys.array[currentProperty]
        
        animator.setValue(value, forKeyPath: "Animate"+key)
    }
}
extension UIViewTestViewController {
    
    override func changeSegment(sender: UISegmentedControl) {
        currentStyle = sender.selectedSegmentIndex
    }
    
    override func changeProperty(row: Int) {
        currentProperty = row
    }
}
