//
//  WelcomeViewController.swift
//  Remember-The-Moments
//
//  Created by Radu Mihaiu on 14.06.2021.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController{
    @IBOutlet weak var label: CLTypingLabel!
    @IBOutlet weak var myButton: UIButton!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "RTM")!)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "RTM"), for: .default)
        label.text = " "
        myButton.setTitleColor(.white, for: .normal)
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 5
        
        
        view.layer.add(animation, forKey: "opacity")
        animation.duration = 14
        var keyFrameAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        keyFrameAnimation.values = [750.0, 0]
        keyFrameAnimation.keyTimes = [0.0, 1.0]
        keyFrameAnimation.duration = 10
        myButton.layer.add(keyFrameAnimation, forKey: "transform.translation.y")
        navigationController?.navigationBar.layer.add(animation, forKey: "opacity")
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.label.text = "Remember the Moments"
        }
    }
}
