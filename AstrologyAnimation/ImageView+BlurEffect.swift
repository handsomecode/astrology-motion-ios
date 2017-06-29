//
//  ImageView+BlurEffect.swift
//  AstrologyAnimation
//
//  Created by Olga Konoreva on 29/06/2017.
//  Copyright © 2017 Handsome. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    func addBlurEffect() -> UIVisualEffectView {

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        self.addSubview(blurEffectView)
        return blurEffectView
    }

    func addRoundBlurEffect(width blurWidth: CGFloat) -> UIVisualEffectView {

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.frame = CGRect(x: 0.5 * (frame.width - blurWidth), y: 0.5 * (frame.width - blurWidth), width: blurWidth, height: blurWidth)
        blurEffectView.layer.cornerRadius = 0.5 * blurWidth
        blurEffectView.clipsToBounds = true

        self.addSubview(blurEffectView)
        return blurEffectView
    }

}
