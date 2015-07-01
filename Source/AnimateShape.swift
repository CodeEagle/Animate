//
//  AnimateShape.swift
//  Pods
//
//  Created by LawLincoln on 15/6/16.
//
//

import UIKit
import pop
// MARK: - CALayer Extension
public extension CAShapeLayer {
    
    public func springs(@noescape closure: (make: SpringShape) -> Void) -> AnimateShape {
        let make = SpringShape()
        closure(make: make)
        make.applyTo(self)
        return make
    }
    
    public func decays(@noescape closure: (make: DecayShape) -> Void) -> AnimateShape {
        let make = DecayShape()
        closure(make: make)
        make.applyTo(self)
        return make
    }
    
    public func basics(@noescape closure: (make: BasicShape) -> Void) -> AnimateShape {
        let make = BasicShape()
        closure(make: make)
        make.applyTo(self)
        return make
    }
    
    public var springs: SpringShape {
        if let make = getAssociate(&AnimateAssociatedKeys.Spring) as? SpringShape{
            return make
        }else{
            let make = SpringShape()
            make.animateWhenSet = true
            make.target = self
            self.associateWith(make, type: &AnimateAssociatedKeys.Spring)
            return make
        }
    }
    
    public var decays: DecayShape {
        if let make = getAssociate(&AnimateAssociatedKeys.Decay) as? DecayShape{
            return make
        }else{
            let make = DecayShape()
            make.animateWhenSet = true
            make.target = self
            self.associateWith(make, type: &AnimateAssociatedKeys.Decay)
            return make
        }
    }
    
    public var basics: BasicShape {
        if let make = getAssociate(&AnimateAssociatedKeys.Basic) as? BasicShape{
            return make
        }else{
            let make = BasicShape()
            make.animateWhenSet = true
            make.target = self
            self.associateWith(make, type: &AnimateAssociatedKeys.Basic)
            return make
        }
    }
    
    private func getAssociate(type:UnsafePointer<Void>)->AnyObject!{
        return objc_getAssociatedObject(self, type)
    }
    
    private func associateWith(view:AnyObject,type:UnsafePointer<Void>){
        objc_setAssociatedObject(self, type, view, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
    }
    
}

// MARK: - Public Function
public extension AnimateShape {
    
    public override func delay(delay:Double)->AnimateShape{
        self.delayTime = delay
        return self
    }
    
    
    public func springs(@noescape closure: (make: SpringShape) -> Void) -> AnimateShape {
        let make = SpringShape()
        closure(make: make)
        nextAnimation = make
        nextAnimation.target = self
        return make
    }
    
    public func decays(@noescape closure: (make: DecayShape) -> Void) -> AnimateShape {
        let make = DecayShape()
        closure(make: make)
        nextAnimation = make
        nextAnimation.target = self
        return make
    }
    
    public func basics(@noescape closure: (make: BasicShape) -> Void) -> AnimateShape {
        let make = BasicShape()
        closure(make: make)
        nextAnimation = make
        nextAnimation.target = self
        return make
    }
    
}



// MARK: - Basic
public class BasicShape: AnimateShape,AnimateApplyProtocol,POPAnimationDelegate {
    /**
    @abstract The duration in seconds. Defaults to 0.4.
    */
    public var duration: CFTimeInterval!
    
    /**
    @abstract A timing function defining the pacing of the animation. Defaults to nil indicating pacing according to kCAMediaTimingFunctionDefault.
    */
    public var timingFunction: CAMediaTimingFunction!
    
    
    deinit{
        debugPrint("deinit Basic")
    }
    
    
    
    public override init() {
        super.init()
        self.type = .Basic
    }
    
    
    // MARK:  ViewAnimateApplyProtocol
    /**
    Apply animate to view
    
    :param: view to animate
    */
    public override func applyTo(view:AnyObject){
        if animates.count == 0 {
            self.playNext()
            return
        }
        self.target = view
        for an in animates {
            if let basicAnim = an as? POPBasicAnimation {
                if !duration {
                    basicAnim.duration = duration!
                }
                if !timingFunction {
                    basicAnim.timingFunction = timingFunction!
                }
                basicAnim.delegate = self
                view.pop_addAnimation(basicAnim, forKey: nil)
            }
        }
    }
    
    public func pop_animationDidStop(anim: POPAnimation!, finished: Bool) {
        self.animateStop(anim, finished: finished)
    }
}
// MARK: - Spring
public class SpringShape: AnimateShape,AnimateApplyProtocol,POPAnimationDelegate{
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
        debugPrint("deinit Spring")
    }
    
    
    
    public override init() {
        super.init()
        type = .Spring
    }
    
    
    // MARK:  ViewAnimateApplyProtocol
    /**
    Apply animate to view
    
    :param: view to animate
    */
    public override func applyTo(view:AnyObject){
        if animates.count == 0 {
            self.playNext()
            return
        }
        self.target = view
        animating = true
        for an in animates {
            if let anim = an as? POPSpringAnimation {
                if !springBounciness {
                    anim.springBounciness = springBounciness!
                }
                if !springSpeed {
                    anim.springSpeed = springSpeed!
                }
                if !dynamicsTension {
                    anim.dynamicsTension = dynamicsTension!
                }
                if !dynamicsFriction {
                    anim.dynamicsFriction = dynamicsFriction!
                }
                if !dynamicsMass {
                    anim.dynamicsMass = dynamicsMass!
                }
                if !velocity {
                    anim.velocity = velocity!
                }
                anim.delegate = self
                view.pop_addAnimation(anim, forKey: nil)
            }
        }
    }
    
    public func pop_animationDidStop(anim: POPAnimation!, finished: Bool) {
        self.animateStop(anim, finished: finished)
    }
    
}
// MARK: - Decay
public class DecayShape: AnimateShape,AnimateApplyProtocol,POPAnimationDelegate{
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
    
    
    
    
    public override init() {
        super.init()
        type = .Decay
    }
    deinit{
        debugPrint("deinit Decay")
    }
    
    public func velocity(v:AnyObject,forProperty property:String){
        let make = POPDecayAnimation(propertyNamed: property)
        velocity = v
        animates.append(make)
    }
    
    // MARK:  ViewAnimateApplyProtocol
    /**
    Apply animate to view
    
    :param: view to animate
    */
    public override func applyTo(view:AnyObject){
        if animates.count == 0 {
            self.playNext()
            return
        }
        self.target = view
        for an in animates {
            if let decayAnim = an as? POPDecayAnimation {
                if !velocity {
                    decayAnim.velocity = velocity!
                }
                if !deceleration {
                    decayAnim.deceleration = deceleration!
                }
                decayAnim.delegate = self
                view.pop_addAnimation(decayAnim, forKey: nil)
            }
        }
    }
    
    public func pop_animationDidStop(anim: POPAnimation!, finished: Bool) {
        self.animateStop(anim, finished: finished)
    }
}


public class AnimateShape: AnimateCALayer, AnimateApplyProtocol{
    deinit{
        debugPrint("deinit AnimateShape")
    }
    
    public var strokeStart: CGFloat!{
        didSet {
            if let value = strokeStart {
                let anim = animator(kPOPShapeLayerStrokeStart)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var strokeEnd: CGFloat!{
        didSet {
            if let value = strokeEnd {
                let anim = animator(kPOPShapeLayerStrokeEnd)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var strokeColor: UIColor!{
        didSet {
            if let value = strokeColor {
                let anim = animator(kPOPShapeLayerStrokeColor)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var fillColor: UIColor!{
        didSet {
            if let value = fillColor {
                let anim = animator(kPOPShapeLayerFillColor)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    
    private func associate(){
        if !self.target {
            objc_setAssociatedObject(self.target, &AnimateAssociatedKeys.SelfRetain, self, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
    }
    // MARK: - private
    private var animateWhenSet: Bool = false
    private var animating: Bool = false
    private var animates = [AnyObject]()
    private var animatesQueue = [AnyObject]()
    private weak var nextAnimation:AnimateShape!
    private var delayTime: Double = 0
    private var type: AnimateType = .Spring
    private weak var target: AnyObject!{
        didSet{
            self.associate()
        }
    }
    private var doneCount: Int = 0
    
    public func applyTo(target: AnyObject) {
        
    }
}
// MARK: - Setter
/*
let kPOPShapeLayerStrokeStart: String
let kPOPShapeLayerStrokeEnd: String
let kPOPShapeLayerStrokeColor: String
let kPOPShapeLayerFillColor: String
*/
extension AnimateShape {
    public func setAnimateStrokeStart(value:CGFloat){
        strokeStart = value
    }
    public func setAnimateStrokeEnd(value:CGFloat){
        strokeEnd = value
    }
    public func setAnimateStrokeColor(value:UIColor){
        strokeColor = value
    }
    public func setAnimateFillColor(value:UIColor){
        fillColor = value
    }
}
// MARK: - Private Function
extension AnimateShape {
    
    private func addAnimate(obj:AnyObject){
        if animating {
            animatesQueue.insert(obj, atIndex: 0)
        }else{
            animates.append(obj)
            if animateWhenSet{
                self.applyTo(self.target)
            }
        }
    }
    
    private func animator(name:String!)->POPPropertyAnimation{
        var anim: POPPropertyAnimation = POPSpringAnimation(propertyNamed: name)
        switch type {
        case .Basic:
            anim = POPBasicAnimation(propertyNamed: name)
            break
        case .Decay:
            anim = POPDecayAnimation(propertyNamed: name)
            break
        default:
            break
        }
        return anim
    }
    
    private func playNext(){
        if animateWhenSet {
            if self.animatesQueue.count > 0 {
                let anim: AnyObject = self.animatesQueue.removeLast()
                addAnimate(anim)
            }
        }else{
            if self.delayTime > 0 {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(self.delayTime
                    * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                        self.play()
                }
            }else{
                play()
            }
        }
    }
    private func play(){
        if !self.nextAnimation {
            self.nextAnimation?.applyTo(self.target)
        }else{
            !doneBlock ? doneBlock() : (debugPrint())
        }
    }
    
    // MARK: - POPAnimationDelegate
    
    private func animateStop(anim: POPAnimation!, finished: Bool) {
        anim.delegate = nil
        doneCount++
        if doneCount == self.animates.count {
            animating = false
            if animateWhenSet {
                self.animates.removeAll(keepCapacity: true)
            }
            doneCount = 0
            self.playNext()
        }
        
    }
}
