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

class ViewController: UIViewController {

    private struct AnimationSettings {

        // Distance to move Sun view
        let sunDistance: CGFloat = 620

        // Distance to move Moon view
        let moonDistance: CGFloat = 140

        // Distance to move icons highlighter
        let highlighterDistance: CGFloat = 93

        // Vector to move particles background image
        let particlesVector = CGVector(dx: 400, dy: -100)

        // Control points for the cubic Bézier timing curve
        let controlPoint1 = CGPoint(x: 0.47, y: 0.21)
        let controlPoint2 = CGPoint(x: 0.17, y: 0.86)
    }

    // MARK: - Animation properties
    //
    private let animationSettings = AnimationSettings()

    @IBOutlet private weak var vignetteBackgroundImage: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var moonInLeoView: UIImageView!
    @IBOutlet private weak var sunInAquariusView: UIImageView!
    @IBOutlet private weak var moonLinesView: UIImageView!
    @IBOutlet private weak var sunLinesView: UIImageView!
    @IBOutlet private weak var bottomIcons: UIImageView!
    @IBOutlet private weak var particlesView: UIImageView!

    @IBOutlet private weak var outterCircle: UIImageView!
    @IBOutlet private weak var innerCircle: UIImageView!
    @IBOutlet private weak var graphView: UIImageView!
    @IBOutlet private weak var graphPointView: UIImageView!

    @IBOutlet private weak var leoView: UIImageView!
    @IBOutlet private weak var aquariusView: UIImageView!
    @IBOutlet private weak var moon: UIImageView!
    @IBOutlet private weak var sun: UIImageView!
    @IBOutlet private weak var highlighterContainer: UIView!

    private let iconsHighlighterView = HighlighterView()
    private var moonBlurEffectView: UIVisualEffectView!
    private var toMoon = true

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Animation implementation
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(iconsTapped(tapGestureRecognizer:)))
        bottomIcons.isUserInteractionEnabled = true
        bottomIcons.addGestureRecognizer(tapGestureRecognizer)

        moonBlurEffectView = moon.addRoundBlurEffect(width: 0.45 * moon.bounds.size.width)
        moonBlurEffectView.alpha = 0

        iconsHighlighterView.alpha = 0.12
        highlighterContainer.addSubview(iconsHighlighterView)
    }

    @objc func iconsTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        toMoon = !toMoon

        // Call combination of animations for the main motion
        //
        animateMoonMovement()
        animateSunMovement()
        animateGraph()
        animateCircles()
        animateParticles()

        // Call additional animations
        //
        animateHighliter()
        animateСonstellationText()
    }


    // MARK: - Main (combined) motion implementation
    //
    private func animateMoonMovement() {
        if toMoon {
            self.leoView.alpha = 1
            self.moonLinesView.alpha = 1
        }
        let moonAnimator = UIViewPropertyAnimator(duration: self.toMoon ? 0.5 : 0.56, controlPoint1: animationSettings.controlPoint1, controlPoint2: animationSettings.controlPoint2, animations: {
            self.moonAnimations()
        })

        moonAnimator.addCompletion { _ in
            if !self.toMoon {
                self.leoView.alpha = 0
                self.moonLinesView.alpha = 0
            }
        }
        moonAnimator.startAnimation(afterDelay: self.toMoon ? 0.2 : 0)
    }

    // Moon scaling, bluring, and movement
    private func moonAnimations() {
        if self.toMoon {
            self.moon.center.x = self.moon.center.x + self.animationSettings.moonDistance
            self.moon.transform = CGAffineTransform.identity
            self.moon.alpha = 1

            self.leoView.center.x = self.moon.center.x
            self.leoView.transform = self.moon.transform

            self.moonLinesView.center.x = self.moon.center.x
            self.moonLinesView.transform = self.moon.transform

            self.moonBlurEffectView.alpha = 0

        } else {
            self.moon.center.x = self.moon.center.x - self.animationSettings.moonDistance
            self.moon.transform = CGAffineTransform(scaleX: 0.16, y: 0.16)
            self.moon.alpha = 0.2

            self.leoView.center.x = self.moon.center.x
            self.leoView.transform = self.moon.transform

            self.moonLinesView.center.x = self.moon.center.x
            self.moonLinesView.transform = self.moon.transform

            self.moonBlurEffectView.alpha = 0.5
        }
    }

    private func animateSunMovement() {
        if !self.toMoon {
            self.sun.isHidden = false
            self.aquariusView.isHidden = false
            self.sunLinesView.isHidden = false
            if self.sun.center.x < self.animationSettings.sunDistance {
                self.sun.center.x = self.sun.center.x + self.animationSettings.sunDistance
                self.aquariusView.center.x = self.sun.center.x
                self.sunLinesView.center.x = self.sun.center.x
                self.sun.transform = CGAffineTransform(scaleX: 7, y: 7)
                self.aquariusView.transform = self.sun.transform
                self.sunLinesView.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
                self.sun.alpha = 0.1
            }
        }

        let sunAnimator = UIViewPropertyAnimator(duration: self.toMoon ? 0.4 : 0.52, controlPoint1: animationSettings.controlPoint1, controlPoint2: animationSettings.controlPoint2, animations: {
            self.sunAnimations()
        })

        sunAnimator.addCompletion { _ in
            if self.toMoon {
                self.sun.isHidden = true
                self.aquariusView.isHidden = true
                self.sunLinesView.isHidden = true
            }
        }
        sunAnimator.startAnimation(afterDelay: self.toMoon ? 0 : 0.18)
    }

    // Sun movement, and scaling
    private func sunAnimations() {
        if self.toMoon {
            self.sun.center.x = self.sun.center.x + self.animationSettings.sunDistance
            self.sun.transform = CGAffineTransform(scaleX: 6, y: 6)
            self.sun.alpha = 0.1

            self.aquariusView.center.x = self.sun.center.x
            self.aquariusView.transform = self.sun.transform

            self.sunLinesView.center.x = self.sun.center.x
            self.sunLinesView.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
            self.sunLinesView.alpha = 0.1

        } else {
            self.sun.center.x = self.sun.center.x - self.animationSettings.sunDistance
            self.sun.transform = CGAffineTransform.identity
            self.sun.alpha = 1

            self.aquariusView.center.x = self.sun.center.x
            self.aquariusView.transform = self.sun.transform

            self.sunLinesView.center.x = self.sun.center.x
            self.sunLinesView.transform = self.sun.transform
            self.sunLinesView.alpha = 1
        }
    }

    // Stretching and curtailing the graph in the center
    private func animateGraph() {
        UIView.animate(withDuration: 0.2, animations: {
            self.graphView.transform = CGAffineTransform(scaleX: 2.4, y: 0.4)
        }, completion: {_ in
            self.graphView.center.x = self.graphView.center.x + (self.toMoon ? 1 : -1) * self.animationSettings.moonDistance
            UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveLinear, animations: {
                self.graphView.alpha = 1
                self.graphPointView.alpha = 1
            }, completion: nil)
        })

        UIView.animate(withDuration: 0.3, animations: {
            self.graphView.alpha = 0
            self.graphPointView.alpha = 0
        })

        UIView.animate(withDuration: 0.2, delay: 0.6, options: .curveLinear, animations: {
            self.graphView.transform = CGAffineTransform.identity
        }, completion: nil)
    }

    // Scaling of the inner and outer circles around a celestial object
    private func animateCircles() {
        func animations(growing: Bool) {
            self.innerCircle.transform = growing ? CGAffineTransform(scaleX: 2, y: 2) : CGAffineTransform.identity
            self.outterCircle.transform = growing ? CGAffineTransform(scaleX: 2, y: 2) : CGAffineTransform.identity
            self.vignetteBackgroundImage.transform = growing ? CGAffineTransform(scaleX: 1.8, y: 1.8) : CGAffineTransform.identity
        }

        let circlesGrowAnimator = UIViewPropertyAnimator(duration: 0.4, controlPoint1: animationSettings.controlPoint1, controlPoint2: animationSettings.controlPoint2, animations: {
            animations(growing: true)
        })
        circlesGrowAnimator.startAnimation()
        circlesGrowAnimator.addCompletion { _ in
            UIViewPropertyAnimator(duration: 0.38, controlPoint1: self.animationSettings.controlPoint1, controlPoint2: self.animationSettings.controlPoint2, animations: {
                animations(growing: false)
            }).startAnimation()
        }
    }

    // The offset of background particles image
    private func animateParticles() {
        UIViewPropertyAnimator(duration: 0.7, controlPoint1: animationSettings.controlPoint1, controlPoint2: animationSettings.controlPoint2, animations: {
            if self.toMoon {
                self.particlesView.center.x = self.particlesView.center.x - self.animationSettings.particlesVector.dx
                self.particlesView.center.y = self.particlesView.center.y - self.animationSettings.particlesVector.dy
                self.particlesView.alpha = 0.6
                self.particlesView.transform = CGAffineTransform.identity
            } else {
                self.particlesView.center.x = self.particlesView.center.x + self.animationSettings.particlesVector.dx
                self.particlesView.center.y = self.particlesView.center.y + self.animationSettings.particlesVector.dy
                self.particlesView.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
        }).startAnimation()
    }


    // MARK: - Additional animations implementation
    //

    // Movement of the icons highlighter at bottom
    private func animateHighliter() {
        iconsHighlighterView.animate(toRight: !toMoon)
        UIView.animate(withDuration: 0.56, delay: 0.0, options: .curveEaseInOut, animations: {
            self.highlighterContainer.center.x = self.highlighterContainer.center.x + (self.toMoon ? -1 : 1) * self.animationSettings.highlighterDistance
        }, completion: nil)
    }

    // Animating the text on top
    private func animateСonstellationText() {
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseIn, animations: {
            if self.toMoon {
                self.sunInAquariusView.alpha = 0
            } else {
                self.moonInLeoView.alpha = 0
            }
        }, completion: nil)
        UIView.animate(withDuration: 0.4, delay: 0.28, options: .curveEaseIn, animations: {
            if self.toMoon {
                self.moonInLeoView.alpha = 1
            } else {
                self.sunInAquariusView.alpha = 1
            }
        }, completion: nil)
    }
}

