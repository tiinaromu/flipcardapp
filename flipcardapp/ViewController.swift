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
    let words = [
        WordPair(wordToLearn: "snadi", translation: "pieni"),
        WordPair(wordToLearn: "buli", translation:"iso"),
        WordPair(wordToLearn: "gimis", translation:"kiva"),
        WordPair(wordToLearn: "kelju", translation:"huono")
    ]
    var wordIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontView = UIView()
        frontView.backgroundColor = UIColor.white
        
        let labelFront = UILabel()
        labelFront.text = words[wordIndex].wordToLearn.uppercased()
        labelFront.textColor = UIColor.black
        labelFront.font = UIFont.boldSystemFont(ofSize: 30)
        
        
        backView = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 300))
        backView.backgroundColor = UIColor.white
        
        let labelBack = UILabel(frame: CGRect(x: 70, y: 70, width: 100, height: 100))
        labelBack.text = words[wordIndex].translation.uppercased()
        labelBack.textColor = UIColor.black
        labelBack.font = UIFont.boldSystemFont(ofSize: 30)
        
        
        frontView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(handleTap(recognizer:))))
        backView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(handleTap(recognizer:))))
        frontView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(recognizer:))))
        backView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(recognizer:))))
        backView.isHidden = true

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
    
    @objc func handleSwipe(recognizer: UIPanGestureRecognizer) {
        let underView = isTurned ? frontView : backView
        let translation = recognizer.translation(in: self.view)
        let state = recognizer.state.rawValue
        if (state < 3) {
            if let view = recognizer.view {
                view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
                underView.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
            }
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        } else if(state == 3) {
            UIView.animate(withDuration: 0.3, animations: {
                self.frontView.center = CGPoint(x:self.view.center.x, y:self.view.center.y)
                self.backView.center = CGPoint(x:self.view.center.x, y:self.view.center.y)
            })
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
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

struct WordPair {
    var wordToLearn: String
    var translation: String
}


