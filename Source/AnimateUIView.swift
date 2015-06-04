//
//  AnimateUIView.swift
//  Pods
//
//  Created by LawLincoln on 15/6/4.
//
//

import Foundation
import pop



// MARK: - Public Function
public extension ViewAnimateBase {

    public func delay(delay:Double)->ViewAnimateBase{
        self.delayTime = delay
        return self
    }
    public func done(done:NextAnimtionBlock){
        self.doneBlock = done
    }
    
    public func spring(@noescape closure: (make: SpringView) -> Void) -> ViewAnimateBase {
        let make = SpringView()
        closure(make: make)
        nextAnimation = make
        return make
    }
    
    public func decay(@noescape closure: (make: DecayView) -> Void) -> ViewAnimateBase {
        let make = DecayView()
        closure(make: make)
        nextAnimation = make
        return make
    }
    
    public func basic(@noescape closure: (make: BasicView) -> Void) -> ViewAnimateBase {
        let make = BasicView()
        closure(make: make)
        nextAnimation = make
        return make
    }
}







// MARK: - Main Class
// MARK: - Basic
public class BasicView: ViewAnimateBase,AnimateApplyProtocol,POPAnimationDelegate {
    /**
    @abstract The duration in seconds. Defaults to 0.4.
    */
    var duration: CFTimeInterval!
    
    /**
    @abstract A timing function defining the pacing of the animation. Defaults to nil indicating pacing according to kCAMediaTimingFunctionDefault.
    */
    var timingFunction: CAMediaTimingFunction!
    
    
    deinit{
        debugPrintln("deinit Basic")
    }
    
    convenience public init(aType: AnimateLayer){
        self.init()
        layerType = aType
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
    public func applyTo(view:AnyObject){
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
public class SpringView: ViewAnimateBase,AnimateApplyProtocol,POPAnimationDelegate{
    /**
    @abstract The current velocity value.
    @discussion Set before animation start to account for initial velocity. Expressed in change of value units per second.
    */
    var velocity: AnyObject!
    
    /**
    @abstract The effective bounciness.
    @discussion Use in conjunction with 'springSpeed' to change animation effect. Values are converted into corresponding dynamics constants. Higher values increase spring movement range resulting in more oscillations and springiness. Defined as a value in the range [0, 20]. Defaults to 4.
    */
    var springBounciness: CGFloat!
    
    /**
    @abstract The effective speed.
    @discussion Use in conjunction with 'springBounciness' to change animation effect. Values are converted into corresponding dynamics constants. Higher values increase the dampening power of the spring resulting in a faster initial velocity and more rapid bounce slowdown. Defined as a value in the range [0, 20]. Defaults to 12.
    */
    var springSpeed: CGFloat!
    
    /**
    @abstract The tension used in the dynamics simulation.
    @discussion Can be used over bounciness and speed for finer grain tweaking of animation effect.
    */
    var dynamicsTension: CGFloat!
    
    /**
    @abstract The friction used in the dynamics simulation.
    @discussion Can be used over bounciness and speed for finer grain tweaking of animation effect.
    */
    var dynamicsFriction: CGFloat!
    
    /**
    @abstract The mass used in the dynamics simulation.
    @discussion Can be used over bounciness and speed for finer grain tweaking of animation effect.
    */
    var dynamicsMass: CGFloat!
    
    
    
    deinit{
        debugPrintln("deinit Spring")
    }
    
    convenience public init(aType: AnimateLayer){
        self.init()
        layerType = aType
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
    public func applyTo(view:AnyObject){
        if animates.count == 0 {
            self.playNext()
            return
        }
        self.target = view
        
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
public class DecayView: ViewAnimateBase,AnimateApplyProtocol,POPAnimationDelegate{
    /**
    @abstract The deceleration factor.
    @discussion Values specifies should be in the range [0, 1]. Lower values results in faster deceleration. Defaults to 0.998.
    */
    var deceleration: CGFloat!
    
    /**
    @abstract The current velocity value.
    @discussion Set before animation start to account for initial velocity. Expressed in change of value units per second. The only POPValueTypes supported for velocity are: kPOPValuePoint, kPOPValueInteger, kPOPValueFloat, kPOPValueRect, and kPOPValueSize.
    */
    private var velocity: AnyObject!
    
    
    convenience public init(aType: AnimateLayer){
        self.init()
        layerType = aType
    }
    
    public override init() {
        super.init()
        type = .Decay
    }
    deinit{
        debugPrintln("deinit Decay")
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
    public func applyTo(view:AnyObject){
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

// MARK: - ViewAnimateBase
public class ViewAnimateBase: NSObject{
    
    deinit{
        debugPrintln("deinit ")
    }
    
    public var alpha: CGFloat!{
        didSet {
            if let value = alpha {
                let anim = animator(kPOPViewAlpha)
                anim.toGenericValue(value,type)
                animates.append(anim)
            }
        }
    }
    public var backgroundColor: UIColor! {
        didSet {
            if let value = backgroundColor {
                let anim = animator(kPOPViewBackgroundColor)
                anim.toValue = value
                animates.append(anim)
            }
        }
    }
    public var bounds: CGRect!{
        didSet {
            if let value = bounds {
                let anim = animator(kPOPViewBounds)
                anim.toGenericValue(NSValue(CGRect:value),type)
                animates.append(anim)
            }
        }
    }
    public var center: CGPoint!{
        didSet {
            if let value = center {
                let anim = animator(kPOPViewCenter)
                anim.toGenericValue(NSValue(CGPoint:value),type)
                animates.append(anim)
            }
        }
    }
    
    public var frame: CGRect! {
        didSet{
            if let value = frame {
                let anim = animator(kPOPViewFrame)
                anim.toGenericValue(NSValue(CGRect:value),type)
                animates.append(anim)
            }
        }
    }
    
    public var scaleX: CGFloat!{
        didSet {
            if let value = scaleX {
                let anim = animator(kPOPViewScaleX)
                anim.toGenericValue(value,type)
                animates.append(anim)
            }
        }
    }
    
    var scaleXY: CGFloat!{
        didSet {
            if let value = scaleXY {
                let anim = animator(kPOPViewScaleXY)
                anim.toGenericValue(NSValue(CGSize: CGSizeMake(value, value)),type)
                animates.append(anim)
            }
        }
    }
    
    public var scaleY: CGFloat!{
        didSet {
            if let value = scaleY {
                let anim = animator(kPOPViewScaleY)
                anim.toGenericValue(value,type)
                animates.append(anim)
            }
        }
    }
    
    public var size: CGSize!{
        didSet {
            if let value = size {
                let anim = animator(kPOPViewSize)
                anim.toGenericValue(NSValue(CGSize:value),type)
                animates.append(anim)
            }
        }
    }
    
    public var tintColor: UIColor!{
        didSet {
            if let value = tintColor {
                let anim = animator(kPOPViewTintColor)
                anim.toValue = value
                animates.append(anim)
            }
        }
    }
    
    
    private var animationKitAssociationKey = "animationKitAssociationKey"
    
    private func associate(){
        if !self.target {
            objc_setAssociatedObject(self.target, &animationKitAssociationKey, self, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        }
    }
    
    private func clear(){
        objc_setAssociatedObject(self.target, &animationKitAssociationKey, nil, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
    }
    
    var doneBlock: NextAnimtionBlock!
    // MARK: - private
    private var animates = [AnyObject]()
    private var nextAnimation:AnyObject!
    private var delayTime: Double = 0
    private var type: AnimateType = .Spring
    private var layerType: AnimateLayer = .UIView
    private weak var target: AnyObject!{
        didSet{
            self.associate()
        }
    }
    private var doneCount: Int = 0
    
    
}
// MARK: - Private Function
public extension ViewAnimateBase {
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
        if self.delayTime > 0 {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(self.delayTime * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                self.play()
            }
        }else{
            play()
        }
    }
    private func play(){
        if !self.nextAnimation {
            self.nextAnimation?.applyTo(self.target)
        }else{
            !doneBlock ? doneBlock() : (debugPrint(""))
            clear()
        }
        
    }
    
    // MARK: - POPAnimationDelegate
    
    private func animateStop(anim: POPAnimation!, finished: Bool) {
        anim.delegate = nil
        doneCount++
        if doneCount == self.animates.count {
            doneCount = 0
            self.playNext()
        }
        
    }
}
