// Playground - noun: a place where people can play

import UIKit
import XCPlayground

var str = "Hello, playground"
var imageView:UIImageView

let image = UIImage(named: "photo1.png")!
imageView = UIImageView(image: image)
//we have to add frame(position of imageView in superview coordinates) before we execute addSubview method
imageView.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: image.size)
imageView.layer.borderWidth  = 20