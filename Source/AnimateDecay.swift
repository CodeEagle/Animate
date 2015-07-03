//
//  AnimateDecay.swift
//  Pods
//
//  Created by LawLincoln on 15/6/24.
//
//

import Foundation
import pop
// MARK: - Decay
public class AnimateDecay: BasicProperties{
    /**
    @abstract The deceleration factor.
    @discussion Values specifies should be in the range [0, 1]. Lower values results in faster deceleration. Defaults to 0.998.
    */
    public var deceleration: CGFloat!
    
    /**
    @abstract The current velocity value.
    @discussion Set before animation start to account for initial velocity. Expressed in change of value units per second. The only POPValueTypes supported for velocity are: kPOPValuePoint, kPOPValueInteger, kPOPValueFloat, kPOPValueRect, and kPOPValueSize.
    */
    public var velocity: AnyObject!
    
    public override init() {
        super.init()
        self.type = .Decay
        weak var wself: AnimateDecay! = self
        applyToBlock = {
            view in
            wself.applyTo(view)
        }
    }
    
    deinit{
//        debugPrint("deinit Decay", appendNewline: true)
    }
}
extension AnimateDecay{
    // MARK:  ViewAnimateApplyProtocol
    /**
    Apply animate to view
    
    - parameter view: to animate
    */
    public func applyTo(view:AnyObject){
        if animates.count == 0 {
            self.playNext()
            return
        }
        self.target = view as! NSObject
        for an in animates {
            if let decayAnim = an as? POPDecayAnimation {
                if !velocity {
                    decayAnim.velocity = velocity!
                }
                if !deceleration {
                    decayAnim.deceleration = deceleration!
                }
                decayAnim.delegate = self
                view.pop_addAnimation(decayAnim, forKey: decayAnim.property.name)
            }
        }
    }
    
    
    public func velocity(v:AnyObject,forProperty property:String){
        let make = POPDecayAnimation(propertyNamed: property)
        velocity = v
        animates.append(make)
    }
}
