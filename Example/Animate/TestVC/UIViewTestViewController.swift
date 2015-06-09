//
//  UIViewTestViewController.swift
//  Animate
//
//  Created by LawLincoln on 15/6/8.
//  Copyright (c) 2015年 CocoaPods. All rights reserved.
//

import UIKit
import Animate
class UIViewTestViewController: TestTemplateViewController {
    
    private var _testView: UIButton!
    var testView: UIButton {
        if ??_testView {
            var size = self.view.frame.size
            _testView = UIButton.buttonWithType(.Custom) as! UIButton
            _testView.frame = CGRectMake(size.width/2-50, 64 + 30, 100, 100)
            _testView.setTitle("Halo", forState: UIControlState.Normal)
            _testView.layer.cornerRadius = 8
            _testView.layer.masksToBounds = true
            _testView.backgroundColor = UIColor.orangeColor()
        }
        return _testView
    }
    
    private var currentProperty: Int = 3 {
        didSet{
            animateCombine()
        }
    }
    private var currentStyle: Int = 0 {
        didSet{
            animateCombine()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "View"
        self.dataList = [
            "alpha":0.1,
            "backgroundColor":UIColor.greenColor(),
            "bounds":NSValue(CGRect: CGRectMake(0, 0, 200, 200)),
            "center":NSValue(CGPoint: CGPointMake(50, 120)),
            "frame":NSValue(CGRect: CGRectMake(60, 210, 80, 200)),
            "scaleX":1.2,
            "scaleXY":NSValue(CGSize:CGSizeMake(0.5, 1.5)),
            "scaleY":1.7,
            "size":NSValue(CGSize:CGSizeMake(50, 50)),
            "tintColor":UIColor.redColor()]
        // Do any additional setup after loading the view.
        self.view.addSubview(self.testView)
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
                self._testView = nil
                self.view.addSubview(self.testView)
                self.Animate()
            }
        }
    }
    
    func Animate(){
        let animator = currentStyle == 0 ? self.testView.spring : (currentStyle == 1 ? self.testView.decay : self.testView.basic)
        
        self.testView.spring.springBounciness = 20
        self.testView.spring.springSpeed = 20
        
        self.testView.basic.timingFunction = CAMediaTimingFunction.easeIn()
        
        var value: AnyObject! = self.dataList.values.array[currentProperty]
        let key = self.dataList.keys.array[currentProperty]
        if currentStyle == 1 && key == "alpha" {
            value = -1.8
        }
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