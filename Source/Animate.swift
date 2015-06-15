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


// MARK: - UIKit Extension

// MARK: - NSLayoutConstraint Extension


public extension NSLayoutConstraint {
//    public func spring(@noescape closure: (make: Spring) -> Void) -> ViewAnimateBase {
//        let make = Spring()
//        closure(make: make)
//        make.applyTo(self)
//        return make
//    }
//    
//    public func decay(@noescape closure: (make: Decay) -> Void) -> ViewAnimateBase {
//        let make = Decay()
//        closure(make: make)
//        make.applyTo(self)
//        return make
//    }
//    
//    public func basic(@noescape closure: (make: Basic) -> Void) -> ViewAnimateBase {
//        let make = Basic()
//        closure(make: make)
//        make.applyTo(self)
//        return make
//    }
}










// MARK: - AnimateApplyProtocol
public protocol AnimateApplyProtocol {
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

// MARK: - Animator

// MARK: - Spring
public class AnimateSpring{
    /**
    @abstract The current velocity value.
    @discussion Set before animation start to account for initial velocity. Expressed in change of value units per second.
    */
    public var velocity: AnyObject!
    
    /**
    @abstract The effective bounciness.
    @discussion Use in conjunction with 'springSpeed' to change animation effect. Values are converted into corresponding dynamics constants. Higher values increase spring movement range resulting in more oscillations and springiness. Defined as a value in the range [0, 20]. Defaults to 4.
    */
    public var springBounciness: CGFloat!
    
    /**
    @abstract The effective speed.
    @discussion Use in conjunction with 'springBounciness' to change animation effect. Values are converted into corresponding dynamics constants. Higher values increase the dampening power of the spring resulting in a faster initial velocity and more rapid bounce slowdown. Defined as a value in the range [0, 20]. Defaults to 12.
    */
    public var springSpeed: CGFloat!
    
    /**
    @abstract The tension used in the dynamics simulation.
    @discussion Can be used over bounciness and speed for finer grain tweaking of animation effect.
    */
    public var dynamicsTension: CGFloat!
    
    /**
    @abstract The friction used in the dynamics simulation.
    @discussion Can be used over bounciness and speed for finer grain tweaking of animation effect.
    */
    public var dynamicsFriction: CGFloat!
    
    /**
    @abstract The mass used in the dynamics simulation.
    @discussion Can be used over bounciness and speed for finer grain tweaking of animation effect.
    */
    public var dynamicsMass: CGFloat!
    
    deinit{
        debugPrintln("deinit Spring")
    }
    
}


// MARK: - Decay
public class AnimateDecay{
    /**
    @abstract The deceleration factor.
    @discussion Values specifies should be in the range [0, 1]. Lower values results in faster deceleration. Defaults to 0.998.
    */
    public var deceleration: CGFloat!
    
    /**
    @abstract The current velocity value.
    @discussion Set before animation start to account for initial velocity. Expressed in change of value units per second. The only POPValueTypes supported for velocity are: kPOPValuePoint, kPOPValueInteger, kPOPValueFloat, kPOPValueRect, and kPOPValueSize.
    */
    private var velocity: AnyObject!
    
    deinit{
        debugPrintln("deinit Decay")
    }
    
}

// MARK: - Basic
public class AniamteBasic{
    /**
    @abstract The duration in seconds. Defaults to 0.4.
    */
    public var duration: CFTimeInterval!
    
    /**
    @abstract A timing function defining the pacing of the animation. Defaults to nil indicating pacing according to kCAMediaTimingFunctionDefault.
    */
    public var timingFunction: CAMediaTimingFunction!
    
    
    deinit{
        debugPrintln("deinit Basic")
    }
}
