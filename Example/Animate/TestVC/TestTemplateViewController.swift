//
//  TestTemplateViewController.swift
//  Animate
//
//  Created by LawLincoln on 15/6/8.
//  Copyright (c) 2015年 CocoaPods. All rights reserved.
//

import UIKit
import Animate
class TestTemplateViewController: UIViewController {
    
    lazy var testView: UIView! = {
        var size = self.view.frame.size
        let atestView = UIButton(frame: CGRectMake(size.width/2-50, 64 + 80, 100, 100))
        atestView.tintColor = UIColor.redColor()
        atestView.setTitle("Halo", forState: UIControlState.Normal)
        atestView.layer.borderColor = UIColor.purpleColor().CGColor
        atestView.layer.borderWidth = 4.0
        atestView.layer.cornerRadius = 8
        atestView.layer.shadowColor = UIColor.whiteColor().CGColor
        atestView.layer.shadowOffset = CGSizeMake(2, 2)
        atestView.layer.shadowOpacity = 0.3
        
        atestView.backgroundColor = UIColor.orangeColor()
        return atestView
        }()
    
    lazy var segmentControl: UISegmentedControl! = {
        let seg = UISegmentedControl(items: ["Spring","Decay","Basic"])
        seg.addTarget(self, action: "changeSegment:", forControlEvents: UIControlEvents.ValueChanged)
        seg.tintColor = UIColor.whiteColor()
        seg.frame = CGRectMake(0, CGRectGetHeight(self.view.frame)-216-44, CGRectGetWidth(self.view.frame), 44)
        seg.selectedSegmentIndex = 0
        return seg
    }()
    lazy var picker: UIPickerView! = {
        let p = UIPickerView(frame: CGRectMake(0, CGRectGetHeight(self.view.frame)-216, CGRectGetWidth(self.view.frame), 216))
        p.delegate = self
        p.dataSource = self
        return p
    }()
    lazy var dataList: [String:AnyObject]! = {
        let value = [String:AnyObject]()
        return value
    }()
    
    lazy var velocityList: [String:AnyObject]! = {
        let value = [String:AnyObject]()
        return value
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.segmentControl)
        self.view.addSubview(self.picker)
        self.view.addSubview(self.testView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}

extension TestTemplateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(dataList.keys)[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.changeProperty(row)
    }
}

extension TestTemplateViewController {
    func changeSegment(sender:UISegmentedControl){
        
    }
    
    func changeProperty(row:Int){
        
    }
}
