//
//  SwiftPop.swift
//  DBFMPlayer
//
//  Created by LawLincoln on 15/6/2.
//  Copyright (c) 2015年 SelfStudio. All rights reserved.
//
/*

/**
Common CAShapeLayer property names.
*/
let kPOPShapeLayerStrokeStart: String
let kPOPShapeLayerStrokeEnd: String
let kPOPShapeLayerStrokeColor: String
let kPOPShapeLayerFillColor: String
let kPOPShapeLayerLineWidth: String

/**
Common NSLayoutConstraint property names.
*/
let kPOPLayoutConstraintConstant: String

/**
Common UIView property names.
*/
let kPOPViewAlpha: String
let kPOPViewBackgroundColor: String
let kPOPViewBounds: String
let kPOPViewCenter: String
let kPOPViewFrame: String
let kPOPViewScaleX: String
let kPOPViewScaleXY: String
let kPOPViewScaleY: String
let kPOPViewSize: String
let kPOPViewTintColor: String

/**
Common UIScrollView property names.
*/
let kPOPScrollViewContentOffset: String
let kPOPScrollViewContentSize: String
let kPOPScrollViewZoomScale: String
let kPOPScrollViewContentInset: String

/**
Common UITableView property names.
*/
let kPOPTableViewContentOffset: String
let kPOPTableViewContentSize: String

/**
Common UICollectionView property names.
*/
let kPOPCollectionViewContentOffset: String
let kPOPCollectionViewContentSize: String

/**
Common UINavigationBar property names.
*/
let kPOPNavigationBarBarTintColor: String

/**
Common UIToolbar property names.
*/
let kPOPToolbarBarTintColor: String

/**
Common UITabBar property names.
*/
let kPOPTabBarBarTintColor: String

/**
Common UILabel property names.
*/
let kPOPLabelTextColor: String
*/

import Foundation
import pop



// MARK: - AnimateApplyProtocol
public protocol AnimateApplyProtocol: class {
    func applyTo(target: AnyObject)
}

// MARK: - New Operator
prefix operator ! { }
public prefix func ! <T>(obj: T?)->Bool{
    if obj == nil{
        return false
    }
    return true
}

prefix operator ?? { }
public prefix func ?? <T>(obj: T?)->Bool{
    if obj == nil{
        return true
    }
    return false
}
public struct AnimateAssociatedKeys {
    static var SelfRetain = "SelfRetain"
    static var Spring     = "Spring"
    static var Decay      = "Decay"
    static var Basic      = "Basic"
    static var Queue      = "Queue"
}


// MARK: - AnimateType
public enum AnimateType : Int {
    case Spring
    case Decay
    case Basic
}

public enum AnimateLayer : Int {
    case CALayer
    case CAShapeLayer
    case NSLayoutConstraint
    case UIView
    case UIScrollView
    case UITableView
    case UICollectionView
    case UINavigationBar
    case UIToolbar
    case UITabBar
    case UILabel
}
public typealias NextAnimtionBlock = ()->Void

// MARK: - Convenience Extension

public extension CAMediaTimingFunction {
    
    class func linear()->CAMediaTimingFunction{
        return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    }
    class func easeIn()->CAMediaTimingFunction{
        return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    }
    class func easeOut()->CAMediaTimingFunction{
        return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    }
    class func easeInOut()->CAMediaTimingFunction{
        return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    }
}

public extension POPPropertyAnimation {
    func toGenericValue(value: AnyObject,_ type: AnimateType){
        if type == .Decay {
            let decay = self as! POPDecayAnimation
            decay.velocity = value
        }else{
            self.toValue = value
        }
    }
}


public extension NSObject {
    
    public func spring(@noescape closure: (make: AnimateSpring) -> Void) -> AnimateSpring {
        let make = AnimateSpring()
        closure(make: make)
        var target:NSObject = self
        if let obj = self as? BasicProperties {
            target = obj.target
        }
        make.target = target
        let op = NSBlockOperation()
        op.addExecutionBlock { () -> Void in
            make.applyTo(target)
        }
        target.AnimatePopQueue.addBlockOperation(op)
        return make
    }
    
    public func decay(@noescape closure: (make: AnimateDecay) -> Void) -> AnimateDecay {
        let make = AnimateDecay()
        closure(make: make)
        var target:NSObject = self
        if let obj = self as? BasicProperties {
            target = obj.target
        }
        make.target = target
        let op = NSBlockOperation()
        op.addExecutionBlock { () -> Void in
            make.applyTo(target)
        }
        target.AnimatePopQueue.addBlockOperation(op)
        return make
    }
    
    public func basic(@noescape closure: (make: AnimateBasic) -> Void) -> AnimateBasic {
        let make = AnimateBasic()
        closure(make: make)
        var target:NSObject = self
        if let obj = self as? BasicProperties {
            target = obj.target
        }
        make.target = target
        let op = NSBlockOperation()
        op.addExecutionBlock { () -> Void in
            make.applyTo(target)
        }
        target.AnimatePopQueue.addBlockOperation(op)
        return make
    }
    // MARK: - Animater
    public var spring: AnimateSpring {
        if let make = getAssociate(&AnimateAssociatedKeys.Spring) as? AnimateSpring{
            return make
        }else{
            let make = AnimateSpring()
            make.animateWhenSet = true
            var target:NSObject = self
            
            if let obj = self as? BasicProperties {
                target = obj.target
            }
            make.target = target
            make.applyTo(target)
            self.associateWith(make, type: &AnimateAssociatedKeys.Spring)
            return make
        }
    }
    
    public var decay: AnimateDecay {
        if let make = getAssociate(&AnimateAssociatedKeys.Decay) as? AnimateDecay{
            return make
        }else{
            let make = AnimateDecay()
            make.animateWhenSet = true
            var target:NSObject = self
            if let obj = self as? BasicProperties {
                target = obj.target
            }
            make.target = target
            make.applyTo(target)
            self.associateWith(make, type: &AnimateAssociatedKeys.Decay)
            return make
        }
    }
    
    public var basic: AnimateBasic {
        if let make = getAssociate(&AnimateAssociatedKeys.Basic) as? AnimateBasic{
            return make
        }else{
            let make = AnimateBasic()
            make.animateWhenSet = true
            var target:NSObject = self
            if let obj = self as? BasicProperties {
                target = obj.target
            }
            make.target = target
            make.applyTo(target)
            self.associateWith(make, type: &AnimateAssociatedKeys.Basic)
            return make
        }
    }
    
}
extension NSMutableArray {
    func addBlockOperation(block:NSBlockOperation){
        self.insertObject(block, atIndex: 0)
        if self.count == 1 {
            block.start()
        }
    }
}
public extension NSObject {
    public var AnimatePopQueue:NSMutableArray {
        if let queue = getAssociate(&AnimateAssociatedKeys.Queue) as? NSMutableArray{
            return queue
        }else{
            let queue = NSMutableArray()
            self.associateWith(queue, type: &AnimateAssociatedKeys.Queue)
            return queue
        }
    }
}
extension NSObject {
    private func getAssociate(type:UnsafePointer<Void>)->AnyObject!{
        return objc_getAssociatedObject(self, type)
    }
    
    private func associateWith(aniamte:AnyObject,type:UnsafePointer<Void>){
        objc_setAssociatedObject(self, type, aniamte, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
    }
}










