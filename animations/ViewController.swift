//
//  ViewController.swift
//  animations
//
//  Created by quentin picard on 11/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var faceOriginalCenter: CGPoint!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // The didPan method
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPanGesture(panGestureRecognizer:)))
        let panTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapGesture(_:)))
        let panSmileyGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onSmileyPanGesture(_:)))
        
        // Attachment to view
        trayView.isUserInteractionEnabled = true
        trayView.addGestureRecognizer(panGestureRecognizer)
        
        trayDownOffset = 205
        trayDown = trayView.center
        trayUp = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onSmileyPanGesture(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            
            // Gesture recognizers know the view they are attached to
            let imageView = sender.view as! UIImageView
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y
            faceOriginalCenter = newlyCreatedFace.center
        } else if sender.state == UIGestureRecognizerState.changed {
            newlyCreatedFace.center = CGPoint(x: faceOriginalCenter.x + translation.x, y: faceOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.ended {
            print("Smiley face was dropped")
        }

    }
    
    
    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer) {
//        let location = sender.location(in: view)
        if trayView.center == trayUp {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
                self.trayView.center = self.trayDown
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
                self.trayView.center = self.trayUp
            }, completion: nil)
        }
        
    }
    
    
    @IBAction func onPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let point = panGestureRecognizer.location(in: view)
        //let translation = sender.translation(in: view)
        let translation = panGestureRecognizer.translation(in: view)
        let velocity = panGestureRecognizer.velocity(in: view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.began {
            trayOriginalCenter = trayView.center
        } else if panGestureRecognizer.state == UIGestureRecognizerState.changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if panGestureRecognizer.state == UIGestureRecognizerState.ended {
            if velocity.y < 0 {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
                    self.trayView.center = self.trayDown
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
                    self.trayView.center = self.trayUp
                }, completion: nil)
            }
            
        }
        
    }

}

