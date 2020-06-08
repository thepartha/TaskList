//
//  TestView.swift
//  TaskList
//
//  Created by Partha Sarathy on 6/7/20.
//  Copyright © 2020 Partha Sarathy. All rights reserved.
//

import UIKit

struct Slice {
    var percent: CGFloat
    var color: UIColor
}
class TestView: UIView, CAAnimationDelegate {
    
    static let ANIMATION_DURATION: CGFloat = 1.4
    @IBOutlet var canvasView: UIView!
    
    var slices: [Slice]?
    var sliceIndex: Int = 0
    var currentPercent: CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let view: UIView = Bundle.main.loadNibNamed("TestView", owner: self, options: nil)!.first as! UIView
        addSubview(view)
    }
    
    override func draw(_ rect: CGRect) {
           subviews[0].frame = bounds
       }
    
    func percentToRadian(_ percent: CGFloat) -> CGFloat {
        //Because angle starts wtih X positive axis, add 270 degrees to rotate it to Y positive axis.
        var angle = 270 + percent * 360
        if angle >= 360 {
            angle -= 360
        }
        return angle * CGFloat.pi / 180.0
    }
    
    
    func getDuration(_ slice: Slice) -> CFTimeInterval {
           return CFTimeInterval(slice.percent / 1.0 * TestView.ANIMATION_DURATION)
       }
       
    
    func addSlice(_ slice: Slice) {
          let animation = CABasicAnimation(keyPath: "strokeEnd")
          animation.fromValue = 0
          animation.toValue = 1
          animation.duration = getDuration(slice)
          animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
          animation.delegate = self
          
          let canvasWidth = canvasView.frame.width
          let path = UIBezierPath(arcCenter: canvasView.center,
                                  radius: canvasWidth * 3 / 8,
                                  startAngle: percentToRadian(currentPercent),
                                  endAngle: percentToRadian(currentPercent + slice.percent),
                                  clockwise: true)
          
          let sliceLayer = CAShapeLayer()
          sliceLayer.path = path.cgPath
          sliceLayer.fillColor = nil
          sliceLayer.strokeColor = slice.color.cgColor
          sliceLayer.lineWidth = canvasWidth * 2 / 8
          sliceLayer.strokeEnd = 1
          sliceLayer.add(animation, forKey: animation.keyPath)
          
          canvasView.layer.addSublayer(sliceLayer)
      }
}
