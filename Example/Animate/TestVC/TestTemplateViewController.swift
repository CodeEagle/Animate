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
    private var _segmentControl: UISegmentedControl!
    private var _picker: UIPickerView!
    private var _dataList: [String:AnyObject]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.segmentControl)
        self.view.addSubview(self.picker)
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

extension TestTemplateViewController{
    var segmentControl: UISegmentedControl {
        if ??_segmentControl {
            _segmentControl = UISegmentedControl(items: ["Spring","Decay","Basic"])
            _segmentControl.addTarget(self, action: "changeSegment:", forControlEvents: UIControlEvents.ValueChanged)
            _segmentControl.tintColor = UIColor.whiteColor()
            _segmentControl.frame = CGRectMake(0, CGRectGetHeight(self.view.frame)-216-44, CGRectGetWidth(self.view.frame), 44)
            _segmentControl.selectedSegmentIndex = 0
        }
        return _segmentControl
    }
    
    var picker: UIPickerView {
        if ??_picker {
            _picker = UIPickerView(frame: CGRectMake(0, CGRectGetHeight(self.view.frame)-216, CGRectGetWidth(self.view.frame), 216))
            _picker.delegate = self
            _picker.dataSource = self
        }
        return _picker
    }
    
    var dataList: [String:AnyObject] {
        get {
            if ??_dataList {
                _dataList = [String:AnyObject]()
            }
            return _dataList
        }
        set {
            _dataList = newValue
        }
        
    }
}

extension TestTemplateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.dataList.keys.array[row]
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
