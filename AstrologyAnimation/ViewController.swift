//
//  ViewController.swift
//  AstrologyAnimation
//
//  Created by Olga Konoreva on 23/06/2017.
//  Copyright © 2017 Handsome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var vignetteBackgroundImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var moonInLeoView: UIImageView!
    @IBOutlet weak var sunInAquariusView: UIImageView!
    @IBOutlet weak var moonLinesView: UIImageView!
    @IBOutlet weak var sunLinesView: UIImageView!
    @IBOutlet weak var bottomIcons: UIImageView!
    @IBOutlet weak var particlesView: UIImageView!

    @IBOutlet weak var outterCircle: UIImageView!
    @IBOutlet weak var innerCircle: UIImageView!
    @IBOutlet weak var graph: UIImageView!
    @IBOutlet weak var graphPointView: UIImageView!

    @IBOutlet weak var leoView: UIImageView!
    @IBOutlet weak var aquariusView: UIImageView!
    @IBOutlet weak var moon: UIImageView!
    @IBOutlet weak var sun: UIImageView!
    @IBOutlet weak var activeIconHighlighter: UIImageView!

    var moonBlurEffectView: UIVisualEffectView!
    var sunBlurEffectView: UIVisualEffectView!

    private let sunDistance: CGFloat = 450
    private let moonDistance: CGFloat = 140

    private var toMoon = true {
        didSet {
            animateHighliter()
            animateObjectPositionText()
            animateCircles()
            animateParticles()
            animateGraph()
            animateMoonMovement()
            animateSunMovement()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(iconsTapped(tapGestureRecognizer:)))
        bottomIcons.isUserInteractionEnabled = true
        bottomIcons.addGestureRecognizer(tapGestureRecognizer)

        moonBlurEffectView = moon.addRoundBlurEffect(width: 0.45 * moon.bounds.size.width)
        moonBlurEffectView.alpha = 0

        sunBlurEffectView = sun.addRoundBlurEffect(width: 0.47 * sun.bounds.size.width)
        sunBlurEffectView.alpha = 0
    }

    func iconsTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        toMoon = !toMoon
    }

    func animateHighliter() {
        UIView.animate(withDuration: 0.56, delay: 0.0, options: .curveEaseInOut, animations: {
            self.activeIconHighlighter.center.x = self.activeIconHighlighter.center.x + (self.toMoon ? -93 : 93)
        }, completion: nil)
    }

    func animateGraph() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
            self.graph.transform = CGAffineTransform(scaleX: 2.4, y: 0.4)
        }, completion: {_ in
            self.graph.center.x = self.graph.center.x + (self.toMoon ? self.moonDistance : -1 * self.moonDistance)
            UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveLinear, animations: {
                self.graph.alpha = 1
                self.graphPointView.alpha = 1
            }, completion: nil)
        })

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {
            self.graph.alpha = 0
            self.graphPointView.alpha = 0
        }, completion: nil)

        UIView.animate(withDuration: 0.2, delay: 0.6, options: .curveLinear, animations: {
            self.graph.transform = CGAffineTransform.identity
        }, completion: nil)
    }

    func animateCircles() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            self.innerCircle.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.outterCircle.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.vignetteBackgroundImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: nil)
        UIView.animate(withDuration: 0.4, delay: 0.46, options: .curveEaseOut, animations: {
            self.innerCircle.transform = CGAffineTransform.identity
            self.outterCircle.transform = CGAffineTransform.identity
            self.vignetteBackgroundImage.transform = CGAffineTransform.identity
        }, completion: nil)
    }

    func animateParticles() {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseInOut, animations: {
            if self.toMoon {
                self.particlesView.center.x = self.particlesView.center.x - 400
                self.particlesView.center.y = self.particlesView.center.y + 100
                self.particlesView.alpha = 0.6
                self.particlesView.transform = CGAffineTransform.identity
            } else {
                self.particlesView.center.x = self.particlesView.center.x + 400
                self.particlesView.center.y = self.particlesView.center.y - 100
                self.particlesView.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
        }, completion: nil)
    }

    func animateObjectPositionText() {
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

    func animateMoonMovement() {
        if toMoon {
            self.leoView.alpha = 1
            self.moonLinesView.alpha = 1
        }

        UIView.animate(withDuration: 0.5, delay: self.toMoon ? 0.15 : 0, options: .curveEaseInOut, animations: {
            if self.toMoon {

                self.moon.center.x = self.moon.center.x + self.moonDistance
                self.moon.transform = CGAffineTransform.identity
                self.moon.alpha = 1

                self.leoView.center.x = self.moon.center.x
                self.leoView.transform = self.moon.transform

                self.moonLinesView.center.x = self.moon.center.x
                self.moonLinesView.transform = self.moon.transform

                self.moonBlurEffectView.alpha = 0

            } else {
                self.moon.center.x = self.moon.center.x - self.moonDistance
                self.moon.transform = CGAffineTransform(scaleX: 0.16, y: 0.16)
                self.moon.alpha = 0.4

                self.leoView.center.x = self.moon.center.x
                self.leoView.transform = self.moon.transform

                self.moonLinesView.center.x = self.moon.center.x
                self.moonLinesView.transform = self.moon.transform

                self.moonBlurEffectView.alpha = 0.5
            }
        }, completion: { _ in
            if !self.toMoon {
                self.leoView.alpha = 0
                self.moonLinesView.alpha = 0
            }
        })
    }

    func animateSunMovement() {
        if !self.toMoon {
            self.sun.isHidden = false
            self.aquariusView.isHidden = false
            self.sunLinesView.isHidden = false
            if sun.center.x < self.sunDistance {
                self.sun.center.x = self.sun.center.x + self.sunDistance
                self.aquariusView.center.x = self.sun.center.x
                self.sunLinesView.center.x = self.sun.center.x
                self.sun.transform = CGAffineTransform(scaleX: 4, y: 4)
                self.aquariusView.transform = self.sun.transform
                self.sunLinesView.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
                self.sun.alpha = 0
            }
        }
        UIView.animate(withDuration: 0.65, delay: self.toMoon ? 0 : 0.05, options: .curveEaseInOut, animations: {
            if self.toMoon {
                self.sun.center.x = self.sun.center.x + self.sunDistance
                self.sun.transform = CGAffineTransform(scaleX: 4, y: 4)
                self.sun.alpha = 0

                self.aquariusView.center.x = self.sun.center.x
                self.aquariusView.transform = self.sun.transform

                self.sunLinesView.center.x = self.sun.center.x
                self.sunLinesView.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
                self.sunLinesView.alpha = 0.1

                self.sunBlurEffectView.alpha = 1
            }
            else {
                self.sun.center.x = self.sun.center.x - self.sunDistance
                self.sun.transform = CGAffineTransform.identity
                self.sun.alpha = 1

                self.aquariusView.center.x = self.sun.center.x
                self.aquariusView.transform = self.sun.transform

                self.sunLinesView.center.x = self.sun.center.x
                self.sunLinesView.transform = self.sun.transform
                self.sunLinesView.alpha = 1

                self.sunBlurEffectView.alpha = 0

            }
        }, completion: { _ in
            if self.toMoon {
                self.sun.isHidden = true
                self.aquariusView.isHidden = true
                self.sunLinesView.isHidden = true
            }
        })
    }

}

