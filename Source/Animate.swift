//
//  SwiftPop.swift
//  DBFMPlayer
//
//  Created by LawLincoln on 15/6/2.
//  Copyright (c) 2015年 SelfStudio. All rights reserved.
//
/*

/**
Common CALayer property names.
*/
let kPOPLayerBackgroundColor: String
let kPOPLayerBounds: String
let kPOPLayerCornerRadius: String
let kPOPLayerBorderWidth: String
let kPOPLayerBorderColor: String
let kPOPLayerOpacity: String
let kPOPLayerPosition: String
let kPOPLayerPositionX: String
let kPOPLayerPositionY: String
let kPOPLayerRotation: String
let kPOPLayerRotationX: String
let kPOPLayerRotationY: String
let kPOPLayerScaleX: String
let kPOPLayerScaleXY: String
let kPOPLayerScaleY: String
let kPOPLayerSize: String
let kPOPLayerSubscaleXY: String
let kPOPLayerSubtranslationX: String
let kPOPLayerSubtranslationXY: String
let kPOPLayerSubtranslationY: String
let kPOPLayerSubtranslationZ: String
let kPOPLayerTranslationX: String
let kPOPLayerTranslationXY: String
let kPOPLayerTranslationY: String
let kPOPLayerTranslationZ: String
let kPOPLayerZPosition: String
let kPOPLayerShadowColor: String
let kPOPLayerShadowOffset: String
let kPOPLayerShadowOpacity: String
let kPOPLayerShadowRadius: String

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
prefix func ! <T>(obj: T?)->Bool{
    if obj == nil{
        return false
    }
    return true
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

