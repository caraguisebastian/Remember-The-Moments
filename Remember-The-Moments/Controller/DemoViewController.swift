//
//  DemoViewController.swift
//  Remember-The-Moments
//
//  Created by Radu Mihaiu on 15.06.2021.
//

import UIKit
import AVFoundation
import AVKit
import WebKit


class DemoViewController: UIViewController{
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var viewOfImage: UIView!
    let audioSession = AVAudioSession.sharedInstance()
    @IBOutlet weak var myWebView: WKWebView!
    let url = URL(string: "https://youtube.com/embed/GJDNkVDGM_s")
    override func viewDidLoad() {
        descriptionView.backgroundColor = .clear
        viewOfImage.backgroundColor = .clear
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: K.backgroundImage)!)
        myWebView.load(URLRequest(url: url!))
    }
    

}
