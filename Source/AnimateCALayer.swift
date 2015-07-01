//
//  AnimateCALayer.swift
//  Pods
//
//  Created by LawLincoln on 15/6/9.
//
//

import UIKit
import pop


// MARK: - CALayer Extension
//public extension CALayer {
//    
//    public func spring(@noescape closure: (make: SpringLayer) -> Void) -> AnimateCALayer {
//        let make = SpringLayer()
//        closure(make: make)
//        make.applyTo(self)
//        return make
//    }
//    
//    public func decay(@noescape closure: (make: DecayLayer) -> Void) -> AnimateCALayer {
//        let make = DecayLayer()
//        closure(make: make)
//        make.applyTo(self)
//        return make
//    }
//    
//    public func basic(@noescape closure: (make: BasicLayer) -> Void) -> AnimateCALayer {
//        let make = BasicLayer()
//        closure(make: make)
//        make.applyTo(self)
//        return make
//    }
//    
//    public var spring: SpringLayer {
//        if let make = getAssociate(&AnimateAssociatedKeys.Spring) as? SpringLayer{
//            return make
//        }else{
//            let make = SpringLayer()
//            make.animateWhenSet = true
//            make.target = self
//            self.associateWith(make, type: &AnimateAssociatedKeys.Spring)
//            return make
//        }
//    }
//    
//    public var decay: DecayLayer {
//        if let make = getAssociate(&AnimateAssociatedKeys.Decay) as? DecayLayer{
//            return make
//        }else{
//            let make = DecayLayer()
//            make.animateWhenSet = true
//            make.target = self
//            self.associateWith(make, type: &AnimateAssociatedKeys.Decay)
//            return make
//        }
//    }
//    
//    public var basic: BasicLayer {
//        if let make = getAssociate(&AnimateAssociatedKeys.Basic) as? BasicLayer{
//            return make
//        }else{
//            let make = BasicLayer()
//            make.animateWhenSet = true
//            make.target = self
//            self.associateWith(make, type: &AnimateAssociatedKeys.Basic)
//            return make
//        }
//    }
//    
//    private func getAssociate(type:UnsafePointer<Void>)->AnyObject!{
//        return objc_getAssociatedObject(self, type)
//    }
//    
//    private func associateWith(view:AnyObject,type:UnsafePointer<Void>){
//        objc_setAssociatedObject(self, type, view, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//    }
//    
//}

// MARK: - Public Function
//public extension AnimateCALayer {
//    
//    public func delay(delay:Double)->AnimateCALayer{
//        self.delayTime = delay
//        return self
//    }
//    public func done(done:NextAnimtionBlock){
//        self.doneBlock = done
//    }
//    
//    public func spring(@noescape closure: (make: SpringLayer) -> Void) -> AnimateCALayer {
//        let make = SpringLayer()
//        closure(make: make)
//        nextAnimation = make
//        (nextAnimation as! AnimateCALayer).target = self
//        return make
//    }
//    
//    public func decay(@noescape closure: (make: DecayLayer) -> Void) -> AnimateCALayer {
//        let make = DecayLayer()
//        closure(make: make)
//        nextAnimation = make
//        (nextAnimation as! AnimateCALayer).target = self
//        return make
//    }
//    
//    public func basic(@noescape closure: (make: BasicLayer) -> Void) -> AnimateCALayer {
//        let make = BasicLayer()
//        closure(make: make)
//        nextAnimation = make
//        (nextAnimation as! AnimateCALayer).target = self
//        return make
//    }
//    
//}

// MARK: - Basic
public class BasicLayer: AnimateCALayer,AnimateApplyProtocol,POPAnimationDelegate {
    /**
    @abstract The duration in seconds. Defaults to 0.4.
    */
    public var duration: CFTimeInterval!
    
    /**
    @abstract A timing function defining the pacing of the animation. Defaults to nil indicating pacing according to kCAMediaTimingFunctionDefault.
    */
    public var timingFunction: CAMediaTimingFunction!
    
    
    deinit{
        debugPrint("deinit Basic", appendNewline: false)
    }
    
    
    
    public override init() {
        super.init()
        self.type = .Basic
    }
    
    
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
public class SpringLayer: AnimateCALayer,AnimateApplyProtocol,POPAnimationDelegate{
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
        debugPrint("deinit Spring", appendNewline: false)
    }
    
    
    
    public override init() {
        super.init()
        type = .Spring
    }
    
    
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
public class DecayLayer: AnimateCALayer,AnimateApplyProtocol,POPAnimationDelegate{
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
        debugPrint("deinit Decay", appendNewline: false)
    }
    
    public func velocity(v:AnyObject,forProperty property:String){
        let make = POPDecayAnimation(propertyNamed: property)
        velocity = v
        animates.append(make)
    }
    
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

// MARK: - AnimateCALayer
public class AnimateCALayer: NSObject {
    deinit{
        debugPrint("deinit AnimateCALayer", appendNewline: false)
    }
    
    public var backgroundColor: UIColor!{
        didSet {
            if let value = backgroundColor {
                let anim = animator(kPOPLayerBackgroundColor)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var bounds: CGRect!{
        didSet {
            if let value = bounds {
                let anim = animator(kPOPLayerBounds)
                anim.toGenericValue(NSValue(CGRect:value),type)
                addAnimate(anim)
            }
        }
    }
    
    public var cornerRadius: CGFloat!{
        didSet {
            if let value = cornerRadius {
                let anim = animator(kPOPLayerCornerRadius)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var borderWidth: CGFloat!{
        didSet {
            if let value = borderWidth {
                let anim = animator(kPOPLayerBorderWidth)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var borderColor: UIColor!{
        didSet {
            if let value = borderColor {
                let anim = animator(kPOPLayerBorderColor)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var opacity: CGFloat!{
        didSet {
            if let value = opacity {
                let anim = animator(kPOPLayerOpacity)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var position: CGPoint!{
        didSet {
            if let value = position {
                let anim = animator(kPOPLayerPosition)
                anim.toGenericValue(NSValue(CGPoint:value),type)
                addAnimate(anim)
            }
        }
    }
    
    public var positionX: CGFloat!{
        didSet {
            if let value = positionX {
                let anim = animator(kPOPLayerPositionX)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var positionY: CGFloat!{
        didSet {
            if let value = positionY {
                let anim = animator(kPOPLayerPositionY)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var rotation: CGFloat!{
        didSet {
            if let value = rotation {
                let anim = animator(kPOPLayerRotation)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var rotationX: CGFloat!{
        didSet {
            if let value = rotationX {
                let anim = animator(kPOPLayerRotationX)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var rotationY: CGFloat!{
        didSet {
            if let value = rotationY {
                let anim = animator(kPOPLayerRotationY)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var scaleX: CGFloat!{
        didSet {
            if let value = scaleX {
                let anim = animator(kPOPLayerScaleX)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var scaleXY: CGSize!{
        didSet {
            if let value = scaleXY {
                let anim = animator(kPOPLayerScaleXY)
                anim.toGenericValue(NSValue(CGSize:value),type)
                addAnimate(anim)
            }
        }
    }
    
    public var scaleY: CGFloat!{
        didSet {
            if let value = scaleY {
                let anim = animator(kPOPLayerScaleY)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var size: CGSize!{
        didSet {
            if let value = size {
                let anim = animator(kPOPLayerSize)
                anim.toGenericValue(NSValue(CGSize:value),type)
                addAnimate(anim)
            }
        }
    }
    
    public var subscaleXY: CGSize!{
        didSet {
            if let value = subscaleXY {
                let anim = animator(kPOPLayerSubscaleXY)
                anim.toGenericValue(NSValue(CGSize:value),type)
                addAnimate(anim)
            }
        }
    }
    
    public var subtranslationX: CGFloat!{
        didSet {
            if let value = subtranslationX {
                let anim = animator(kPOPLayerSubtranslationX)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var subtranslationXY: CGSize!{
        didSet {
            if let value = subtranslationXY {
                let anim = animator(kPOPLayerSubtranslationXY)
                anim.toGenericValue(NSValue(CGSize:value),type)
                addAnimate(anim)
            }
        }
    }
    
    public var subtranslationY: CGFloat!{
        didSet {
            if let value = subtranslationY {
                let anim = animator(kPOPLayerSubtranslationY)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var subtranslationZ: CGFloat!{
        didSet {
            if let value = subtranslationZ {
                let anim = animator(kPOPLayerSubtranslationZ)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var translationX: CGFloat!{
        didSet {
            if let value = translationX {
                let anim = animator(kPOPLayerTranslationX)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var translationXY: CGSize!{
        didSet {
            if let value = translationXY {
                let anim = animator(kPOPLayerTranslationXY)
                anim.toGenericValue(NSValue(CGSize:value),type)
                addAnimate(anim)
            }
        }
    }
    
    public var translationY: CGFloat!{
        didSet {
            if let value = translationY {
                let anim = animator(kPOPLayerTranslationY)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var translationZ: CGFloat!{
        didSet {
            if let value = translationZ {
                let anim = animator(kPOPLayerTranslationZ)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var zPosition: CGPoint!{
        didSet {
            if let value = zPosition {
                let anim = animator(kPOPLayerZPosition)
                anim.toGenericValue(NSValue(CGPoint:value),type)
                addAnimate(anim)
            }
        }
    }
    
    public var shadowColor: UIColor!{
        didSet {
            if let value = shadowColor {
                let anim = animator(kPOPLayerShadowColor)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var shadowOffset: CGSize!{
        didSet {
            if let value = shadowOffset {
                let anim = animator(kPOPLayerShadowOffset)
                anim.toGenericValue(NSValue(CGSize:value),type)
                addAnimate(anim)
            }
        }
    }
    
    public var shadowOpacity: CGFloat!{
        didSet {
            if let value = shadowOpacity {
                let anim = animator(kPOPLayerShadowOpacity)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var shadowRadius: CGFloat!{
        didSet {
            if let value = shadowRadius {
                let anim = animator(kPOPLayerShadowRadius)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    
    
    
    private func associate(){
        if !self.target {
            objc_setAssociatedObject(self.target, &AnimateAssociatedKeys.SelfRetain, self, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var doneBlock: NextAnimtionBlock!
    // MARK: - private
    private var animateWhenSet: Bool = false
    private var animating: Bool = false
    private var animates = [AnyObject]()
    private var animatesQueue = [AnyObject]()
    private weak var nextAnimation:AnyObject!
    private var delayTime: Double = 0
    private var type: AnimateType = .Spring
    private weak var target: AnyObject!{
        didSet{
            self.associate()
        }
    }
    private var doneCount: Int = 0
    
    private func addAnimate(obj:AnyObject){
        if animating {
            animatesQueue.insert(obj, atIndex: 0)
        }else{
            animates.append(obj)
            if animateWhenSet{
                (self as AnyObject).applyTo(self.target)
            }
        }
    }
}


// MARK: - Setter
extension AnimateCALayer {
    public func setAnimateBackgroundColor(value:UIColor){
        backgroundColor = value
    }
    public func setAnimateBounds(value:NSValue){
        bounds = value.CGRectValue()
    }
    public func setAnimateCornerRadius(value:CGFloat){
        cornerRadius = value
    }
    public func setAnimateBorderWidth(value:CGFloat){
        borderWidth = value
    }
    public func setAnimateBorderColor(value:UIColor){
        borderColor = value
    }
    public func setAnimateOpacity(value:CGFloat){
        opacity = value
    }
    public func setAnimatePosition(value:CGPoint){
        position = value
    }
    public func setAnimatePositionX(value:CGFloat){
        positionX = value
    }
    public func setAnimatePositionY(value:CGFloat){
        positionY = value
    }
    public func setAnimateRotation(value:CGFloat){
        rotation = value
    }
    public func setAnimateRotationX(value:CGFloat){
        rotationX = value
    }
    public func setAnimateRotationY(value:CGFloat){
        rotationY = value
    }
    public func setAnimateScaleX(value:CGFloat){
        scaleX = value
    }
    public func setAnimateScaleXY(value:CGSize){
        scaleXY = value
    }
    public func setAnimateScaleY(value:CGFloat){
        scaleY = value
    }
    public func setAnimateSize(value:CGSize){
        size = value
    }
    public func setAnimateSubscaleXY(value:CGSize){
        subscaleXY = value
    }
    public func setAnimateSubtranslationX(value:CGFloat){
        subtranslationX = value
    }
    public func setAnimateSubtranslationXY(value:CGSize){
        subtranslationXY = value
    }
    public func setAnimateSubtranslationY(value:CGFloat){
        subtranslationY = value
    }
    public func setAnimateSubtranslationZ(value:CGFloat){
        subtranslationZ = value
    }
    public func setAnimateTranslationX(value:CGFloat){
        translationX = value
    }
    public func setAnimateTranslationXY(value:CGSize){
        translationXY = value
    }
    public func setAnimateTranslationY(value:CGFloat){
        translationY = value
    }
    public func setAnimateTranslationZ(value:CGFloat){
        translationZ = value
    }
    public func setAnimateZPosition(value:CGPoint){
        zPosition = value
    }
    public func setAnimateShadowColor(value:UIColor){
        shadowColor = value
    }
    public func setAnimateShadowOffset(value:CGSize){
        shadowOffset = value
    }
    public func setAnimateShadowOpacity(value:CGFloat){
        shadowOpacity = value
    }
    public func setAnimateShadowRadius(value:CGFloat){
        shadowRadius = value
    }
}

// MARK: - Private Function
extension AnimateCALayer {
    
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
            !doneBlock ? doneBlock() : (debugPrint("", appendNewline: false))
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
