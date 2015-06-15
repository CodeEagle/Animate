//
//  CALayerTestViewController.swift
//  Animate
//
//  Created by LawLincoln on 15/6/8.
//  Copyright (c) 2015年 CocoaPods. All rights reserved.
//

import UIKit
import pop
import Animate
class CALayerTestViewController: TestTemplateViewController {
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
        self.testView.layer.spring { (make) -> Void in
            make.backgroundColor = UIColor.greenColor()
            make.bounds = CGRectMake(0, 0, 200, 200)
            }.decay { (make) -> Void in
                make.velocity(M_PI * 180, forProperty: kPOPLayerRotationY)
            }.basic { (make) -> Void in
                make.bounds = CGRectMake(0, 0, 100, 100)
                make.position = CGPointMake(self.view.bounds.size.width/2 - 50, 64 + 80);
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Layer"
        let r = Double(30.0)*M_PI
        let rx = Double(-30.0)*M_PI
        let ry = Double(80.0)*M_PI
        self.dataList = [
            "BackgroundColor":UIColor.greenColor(),
            "Bounds":NSValue(CGRect: CGRectMake(0, 0, 200, 200)),
            "CornerRadius":50,
            "BorderWidth":6.0,
            "BorderColor":UIColor.orangeColor(),
            "Opacity":0.1,
            "Position":NSValue(CGPoint:CGPointMake(200, 100)),
            "PositionX":150,
            "PositionY":160,
            "Rotation":r,
            "RotationX":rx,
            "RotationY":ry,
            "ScaleX":2.0,
            "ScaleXY":NSValue( CGSize:CGSizeMake(2.0, 2.0)),
            "ScaleY":2.0,
            "Size":NSValue(CGSize:CGSizeMake(200.0, 200.0)),
            "SubscaleXY":NSValue(CGSize:CGSizeMake(5.0, 5.0)),
            "SubtranslationX":120,
            "SubtranslationXY":NSValue(CGSize:CGSizeMake(120.0, 100.0)),
            "SubtranslationY":100,
            "SubtranslationZ":90,
            "TranslationX":80,
            "TranslationXY":NSValue(CGSize:CGSizeMake(70, 90)),
            "TranslationY":100,
            "TranslationZ":120,
            "ZPosition":300,
            "ShadowColor":UIColor.cyanColor(),
            "ShadowOffset":NSValue(CGSize:CGSizeMake(20, 10)),
            "ShadowOpacity":0.7,
            "ShadowRadius":40
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
        let animator = currentStyle == 0 ? self.testView.layer.spring : (currentStyle == 1 ? self.testView.layer.decay : self.testView.layer.basic)
        
        self.testView.layer.spring.springBounciness = 20
        self.testView.layer.spring.springSpeed = 20
        
        self.testView.layer.basic.timingFunction = CAMediaTimingFunction.easeIn()
        
        var value: AnyObject! = self.dataList.values.array[currentProperty]
        let key = self.dataList.keys.array[currentProperty]
        if currentStyle == 1 && key == "Alpha" {
            value = -1.8
        }
        animator.setValue(value, forKeyPath: "Animate"+key)
    }

}
extension CALayerTestViewController {
    
    override func changeSegment(sender: UISegmentedControl) {
        currentStyle = sender.selectedSegmentIndex
    }
    
    override func changeProperty(row: Int) {
        currentProperty = row
    }
}