//
//  BasicProperties.swift
//  Pods
//
//  Created by LawLincoln on 15/6/24.
//
//
import Foundation
import pop

public class BasicProperties: NSObject {
    // MARK: - UIView
    public var alpha: CGFloat!{
        didSet {
            if let value = alpha {
                let anim = animator(kPOPViewAlpha)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
   
    public var center: CGPoint!{
        didSet {
            if let value = center {
                let anim = animator(kPOPViewCenter)
                anim.toGenericValue(NSValue(CGPoint:value),type)
                addAnimate(anim)
            }
        }
    }
    
    public var frame: CGRect! {
        didSet{
            if let value = frame {
                let anim = animator(kPOPViewFrame)
                anim.toGenericValue(NSValue(CGRect:value),type)
                addAnimate(anim)
            }
        }
    }
    
    public var tintColor: UIColor!{
        didSet {
            if let value = tintColor {
                if self.type != .Decay {
                    let anim = animator(kPOPViewTintColor)
                    anim.toValue = value
                    addAnimate(anim)
                }
            }
        }
    }
    // MARK: - Common
    public var backgroundColor: UIColor!{
        didSet {
            if let value = backgroundColor {
                var key = kPOPLayerBackgroundColor
                if self.target is UIView {
                    key = kPOPViewBackgroundColor
                }
                let anim = animator(key)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var bounds: CGRect!{
        didSet {
            if let value = bounds {
                var key = kPOPLayerBounds
                if self.target is UIView {
                    key = kPOPViewBounds
                }
                let anim = animator(key)
                anim.toGenericValue(NSValue(CGRect:value),type)
                addAnimate(anim)
            }
        }
    }
    
    
    public var scaleX: CGFloat!{
        didSet {
            if let value = scaleX {
                var key = kPOPLayerScaleX
                if self.target is UIView {
                    key = kPOPViewScaleX
                }
                let anim = animator(key)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var scaleXY: CGSize!{
        didSet {
            if let value = scaleXY {
                var key = kPOPLayerScaleXY
                if self.target is UIView {
                    key = kPOPViewScaleXY
                }
                let anim = animator(key)
                anim.toGenericValue(NSValue(CGSize:value),type)
                addAnimate(anim)
            }
        }
    }
    
    public var scaleY: CGFloat!{
        didSet {
            if let value = scaleY {
                var key = kPOPLayerScaleY
                if self.target is UIView {
                    key = kPOPViewScaleY
                }
                let anim = animator(key)
                anim.toGenericValue(value,type)
                addAnimate(anim)
            }
        }
    }
    
    public var size: CGSize!{
        didSet {
            if let value = size {
                var key = kPOPLayerSize
                if self.target is UIView {
                    key = kPOPViewSize
                }
                let anim = animator(key)
                anim.toGenericValue(NSValue(CGSize:value),type)
                addAnimate(anim)
            }
        }
    }
    
    // MARK: - CALayer
    
    
    
    
    
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
    
    
    typealias ApplyToProtocol = (AnyObject)->Void
    var applyToBlock: ApplyToProtocol!
    var doneBlock: NextAnimtionBlock!
    // MARK: - private
     var animateWhenSet: Bool = false
     var animating: Bool = false
     var animates = [AnyObject]()
     var animatesQueue = [AnyObject]()
     var delayTime: Double = 0
     var type: AnimateType = .Spring
     weak var target: NSObject!{
        didSet{
            self.associate()
        }
    }
     var doneCount: Int = 0
    
     func addAnimate(obj:AnyObject){
        if animating {
            animatesQueue.insert(obj, atIndex: 0)
        }else{
            animates.append(obj)
            if animateWhenSet{
                if self.target != nil {
                    applyToBlock?(self.target)
                }
                
            }
        }
    }
}

// MARK: - Setter
extension BasicProperties {
    
    // MARK: - Common
    public func setAnimateBackgroundColor(value:UIColor){
        backgroundColor = value
    }
    public func setAnimateBounds(value:NSValue){
        bounds = value.CGRectValue()
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
    
    // MARK: - UIView
    
    public func setAnimateAlpha(value:CGFloat){
        alpha = value
    }
    public func setAnimateTintColor(value:UIColor){
        tintColor = value
    }
    public func setAnimateFrame(value:NSValue){
        frame = value.CGRectValue()
    }
    public func setAnimateCenter(value:NSValue){
        center = value.CGPointValue()
    }
    // MARK: - CALayer
    
    
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
extension BasicProperties: POPAnimationDelegate {
    
    private func associate(){
        if !self.target {
            objc_setAssociatedObject(self.target, &AnimateAssociatedKeys.SelfRetain, self, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
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
    
     func playNext(){
//        debugPrint("play", appendNewline: true)
        if animateWhenSet {
            if self.animatesQueue.count > 0 {
                let anim: AnyObject = self.animatesQueue.removeLast()
                addAnimate(anim)
            }
        }else{
//            debugPrint("delay:\(self.delayTime)", appendNewline: true)
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
//        debugPrint("next", appendNewline: true)
        if self.target.AnimatePopQueue.count > 0 {
            self.target.AnimatePopQueue.removeLastObject()
            if self.target.AnimatePopQueue.count > 0 {
                if let block = self.target.AnimatePopQueue.lastObject as? NSBlockOperation {
                    block.start()
                }
            }
        }else{
            !doneBlock ? doneBlock() : (debugPrint("no more animate", appendNewline: false))
        }
    }
    
    // MARK: - POPAnimationDelegate
    
    public func pop_animationDidStop(anim: POPAnimation!, finished: Bool) {
        self.animateStop(anim, finished: finished)
    }
    
    func animateStop(anim: POPAnimation!, finished: Bool) {
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
// MARK: - Public Function
public extension BasicProperties {
    public func delay(delay:Double)->BasicProperties{
        self.delayTime = delay
        return self
    }
    public func done(done:NextAnimtionBlock){
        self.doneBlock = done
    }
}
