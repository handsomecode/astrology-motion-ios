# iOS Astrology Animation

Our design team at Handsome created an [amazing Astrology animation](https://dribbble.com/shots/2299696-Astrology-Mobile-App-Animation). 
The engeneering team took up a challenge to implement this animation for iOS.

#### If you like the result, please, give your :star: to this repository.

![implemented animation](https://user-images.githubusercontent.com/2081318/29116685-70f27a12-7d1d-11e7-9cda-0dcc4662ddb9.gif)

It was decided to use [iOS10 Animation SDK](https://developer.apple.com/reference/uikit/uiviewanimating) in order to control timing functions, so that the animation looks more identical to the designed one. For simple motions we used typical [UIView animations](https://developer.apple.com/documentation/uikit/uiview/1622515-animatewithduration). Also, we added a bubbly motion effect to the circle on the bottom icons using [Core Animation](https://developer.apple.com/documentation/quartzcore/cabasicanimation).

The Astrology motion is combined with a few independent animations like Moon and Sun movement, animating circles around the space objects, partickles effect, graph stretching, and a few more motions. Please, check out the implementation to get more details.

### A few things from Animations SDK that you'll find in the code

- Working with `UIViewPropertyAnimator` objects;
- Creating custom-easing functions, based on Cubic Bézier curves.


If you are interested in more features of iOS10 Animations SDK, take a look into the article - [Crafting Delightful Animations in iOS 10](http://handsome.is/crafting-delightful-animations-in-ios-10/).

# Requirements
- iOS 10.0+
- Xcode 8.1+
- Swift 3.0+

# License
AstrologyAnimation is available under the Apache License, Version 2.0. See the [LICENSE](./LICENSE) file for more info.
