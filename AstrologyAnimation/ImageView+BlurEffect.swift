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
