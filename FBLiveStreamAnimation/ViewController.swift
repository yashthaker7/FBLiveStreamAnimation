//
//  ViewController.swift
//  FBLiveStreamAnimation
//
//  Created by Yash Thaker on 18/05/18.
//  Copyright © 2018 Yash Thaker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imagesArray = [#imageLiteral(resourceName: "like"), #imageLiteral(resourceName: "heart"), #imageLiteral(resourceName: "wow"), #imageLiteral(resourceName: "happy"), #imageLiteral(resourceName: "sad"), #imageLiteral(resourceName: "angry")]
    
    var fbAnimationView: FBAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFBAnimationView()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapped)))
    }
    
    func setupFBAnimationView() {
        fbAnimationView = FBAnimationView()
        fbAnimationView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(fbAnimationView)
        [fbAnimationView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -50),
        fbAnimationView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        fbAnimationView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
        fbAnimationView.heightAnchor.constraint(equalToConstant: 250)].forEach { ($0.isActive = true)  }
    }
    
    @objc func handleTapped() {
        let randomIndex = Int(arc4random_uniform(UInt32(imagesArray.count)))
        let randomImage = imagesArray[randomIndex]
        
        fbAnimationView.animate(icon: randomImage)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}

