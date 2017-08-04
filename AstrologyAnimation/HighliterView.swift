//
// Copyright © 2017 Handsome.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
/////////////////////////////////////////////////////////////////////////////


import UIKit

let color = UIColor(red: 0.843, green: 0.882, blue: 0.961, alpha: 1.0)

class HighlitherView: UIView {

    let tailLayer = CAShapeLayer()
    let ovalLayer = CAShapeLayer()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func didMoveToSuperview() {
        backgroundColor = UIColor.clear

        ovalLayer.path = UIBezierPath(ovalIn: CGRect(x: 45, y: 0, width: 55, height: 55)).cgPath
        ovalLayer.fillColor = color.cgColor
        layer.addSublayer(ovalLayer)

        tailLayer.fillColor = color.cgColor
        layer.addSublayer(tailLayer)
    }

    func animate(toRight: Bool) {
        let showTailAnimation = CABasicAnimation(keyPath: "path")
        showTailAnimation.duration = 0.3
        showTailAnimation.fromValue = toRight ? rightHiddenTail() : leftHiddenTail()
        showTailAnimation.toValue = toRight ? rightTail() : leftTail()
        showTailAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        let hideTailAnimation = CABasicAnimation(keyPath: "path")
        hideTailAnimation.duration = 0.26
        hideTailAnimation.beginTime = CACurrentMediaTime() + 0.3
        hideTailAnimation.toValue = toRight ? rightHiddenTail() : leftHiddenTail()
        hideTailAnimation.fromValue = toRight ? rightTail() : leftTail()
        hideTailAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        tailLayer.add(showTailAnimation, forKey: nil)
        tailLayer.add(hideTailAnimation, forKey: nil)
    }

    func rightHiddenTail() -> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 77.5, y: 0))
        bezierPath.addQuadCurve(to: CGPoint(x: 77.5, y: 55), controlPoint: CGPoint(x: 115, y: 27.5))
        return bezierPath.cgPath
    }

    func rightTail() -> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 77.5, y: 0))
        bezierPath.addQuadCurve(to: CGPoint(x: 77.5, y: 55), controlPoint: CGPoint(x: 145, y: 27.5))
        return bezierPath.cgPath
    }

    func leftHiddenTail() -> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 67.5, y: 0))
        bezierPath.addQuadCurve(to: CGPoint(x: 67.5, y: 55), controlPoint: CGPoint(x: 35, y: 27.5))
        return bezierPath.cgPath
    }

    func leftTail() -> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 67.5, y: 0))
        bezierPath.addQuadCurve(to: CGPoint(x: 67.5, y: 55), controlPoint: CGPoint(x: -5, y: 27.5))
        return bezierPath.cgPath
    }
}

