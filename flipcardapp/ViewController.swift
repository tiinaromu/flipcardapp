//
//  ViewController.swift
//  flipcardapp
//
//  Created by Tiina Romu on 03/03/2018.
//  Copyright © 2018 Tiina Romu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isTurned = false
    var frontView = UIView()
    var backView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontView = UIView()
        frontView.backgroundColor = UIColor.white
        
        let labelFront = UILabel()
        labelFront.text = "snadi".uppercased()
        labelFront.textColor = UIColor.black
        labelFront.font = UIFont.boldSystemFont(ofSize: 30)
        
        
        backView = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 300))
        backView.backgroundColor = UIColor.white
        
        let labelBack = UILabel(frame: CGRect(x: 70, y: 70, width: 100, height: 100))
        labelBack.text = "pieni".uppercased()
        labelBack.textColor = UIColor.black
        labelBack.font = UIFont.boldSystemFont(ofSize: 30)
        
        
        frontView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(handleTap(sender:))))
        
        backView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(handleTap(sender:))))
        
        self.view.addSubview(backView)
        self.view.addSubview(frontView)
        frontView.addSubview(labelFront)
        backView.addSubview(labelBack)
        
        [frontView, labelFront, backView, labelBack].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
        frontView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        frontView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        frontView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -140).isActive = true
        frontView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -250).isActive = true
        
        labelFront.centerXAnchor.constraint(equalTo: frontView.centerXAnchor).isActive = true
        labelFront.centerYAnchor.constraint(equalTo: frontView.centerYAnchor).isActive = true
        
        backView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -140).isActive = true
        backView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -250).isActive = true
        
        labelBack.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        labelBack.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let toView = isTurned ? frontView : backView
        let fromView = isTurned ? backView : frontView
        UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
        isTurned = !isTurned
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

