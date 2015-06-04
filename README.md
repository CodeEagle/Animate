# Animate
Convenience tool for the Pop animation framework written in Swift 

[![Version](https://img.shields.io/cocoapods/v/Animate.svg?style=flat)](http://cocoapods.org/pods/Animate)
[![License](https://img.shields.io/cocoapods/l/Animate.svg?style=flat)](http://cocoapods.org/pods/Animate)
[![Platform](https://img.shields.io/cocoapods/p/Animate.svg?style=flat)](http://cocoapods.org/pods/Animate)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
import Animate

var view:UIView! = UIView(frame: CGRectMake(10, 10, 50, 50))
view.backgroundColor = UIColor.orangeColor()
self.view.addSubview(view)
view.basic { (make) -> Void in
                make.backgroundColor = UIColor.grayColor()
                make.center = CGPointMake(200, 200)
            }.delay(1)
            .spring({ (make) -> Void in
                make.backgroundColor = UIColor.orangeColor()
                make.center = CGPointMake(200, 300)
            }).delay(1)
            .decay({ (make) -> Void in
                make.velocity(NSValue(CGPoint:CGPointMake(150, 150)),forProperty:kPOPViewCenter)
                make.velocity(NSValue(CGRect:CGRectMake(0, 0, 200, 200)),forProperty:kPOPViewBounds)
            }).delay(1)
            .done { () -> Void in
                view.removeFromSuperview()
                view = nil
            }
```

## Requirements
iOS 8.0 or later


## Installation

Animate is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Animate"
```

## Todo Next

- [x] UIView Support
- [ ] CAShapeLayer Support
- [ ] NSLayoutConstraint Support
- [ ] UIScrollView Support
- [ ] UITableView Support
- [ ] UICollectionView Support
- [ ] UINavigationBar Support
- [ ] UIToolbar Support
- [ ] UITabBar Support
- [ ] UILabel Support



## Author

[CodeEagle](https://twitter.com/_SelfStudio), stasura@hotmail.com

## License

Animate is available under the MIT license. See the LICENSE file for more info.
