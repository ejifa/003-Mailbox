//
//  AnotherViewController.swift
//  003-Mailbox
//
//  Created by Jakub Burkot on 2/18/15.
//  Copyright (c) 2015 Jakub Burkot. All rights reserved.
//

import UIKit

class AnotherViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var messageView: UIImageView!
    
    @IBOutlet var messageContainer: UIView!
    
    @IBOutlet weak var archiveImageView: UIImageView!
    @IBOutlet weak var deleteImageView: UIImageView!
    @IBOutlet weak var laterImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var rescheduleImageView: UIImageView!
    @IBOutlet weak var listTableImageView: UIImageView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var searchContainer: UIView!
    
    let gray    = UIColor(red:0.67, green:0.67, blue:0.67, alpha:1)
    let yellow  = UIColor(red:0.97, green:0.91, blue:0.11, alpha:1)
    let brown   = UIColor(red:0.55, green:0.34, blue:0.16, alpha:1)
    let green   = UIColor(red:0.46, green:0.68, blue:0.21, alpha:1)
    let red     = UIColor(red:0.82, green:0.01, blue:0.11, alpha:1)

    var laterX: CGFloat!
    var archiveX: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = listView.frame.size
        
        laterImageView.alpha = 0
        archiveImageView.alpha = 0
        listImageView.alpha = 0
        deleteImageView.alpha = 0
        listImageView.alpha = 0
        rescheduleImageView.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            
            laterX = laterImageView.frame.origin.x
            archiveX = archiveImageView.frame.origin.x
            
            UIView.animateWithDuration(0.75, animations: { () -> Void in
                self.laterImageView.alpha = 1
                self.archiveImageView.alpha = 1
            })
            
            messageContainer.backgroundColor = gray
            
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            
            messageView.frame.origin.x = translation.x
            
            if (-260 <= translation.x) && (translation.x < -60) {
                messageContainer.backgroundColor = yellow
                laterImageView.transform = CGAffineTransformMakeTranslation(translation.x + 60, 0)
                laterImageView.alpha = 1
                listImageView.alpha = 0
                
                deleteImageView.alpha = 0
                archiveImageView.alpha = 0
                }
            
            else if (-360 <= translation.x) && (translation.x < -260) {
                messageContainer.backgroundColor = brown
                listImageView.transform = CGAffineTransformMakeTranslation(translation.x + 60, 0)
                laterImageView.transform = CGAffineTransformMakeTranslation(translation.x + 60, 0)
                listImageView.alpha = 1
                laterImageView.alpha = 0
                
                deleteImageView.alpha = 0
                archiveImageView.alpha = 0
                
                }
            
            else if (60 <= translation.x) && (translation.x < 260) {
                messageContainer.backgroundColor = green
                archiveImageView.transform = CGAffineTransformMakeTranslation(translation.x - 60, 0)
                deleteImageView.alpha = 0
                archiveImageView.alpha = 1
                
                listImageView.alpha = 0
                laterImageView.alpha = 0
                }
                
            else if (160 <= translation.x) && (translation.x < 320) {
                messageContainer.backgroundColor = red
                deleteImageView.transform = CGAffineTransformMakeTranslation(translation.x - 60, 0)
                archiveImageView.transform = CGAffineTransformMakeTranslation(translation.x - 60, 0)
                deleteImageView.alpha = 1
                archiveImageView.alpha = 0
                listImageView.alpha = 0
                laterImageView.alpha = 0
                }
            
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            if velocity.x < -500 {
                
                messageContainer.backgroundColor = yellow
                UIView.animateWithDuration(0.9, animations: { () -> Void in
                    self.messageView.frame.origin.x = -self.messageView.frame.size.width
                    self.laterImageView.alpha = 0
                    self.rescheduleImageView.alpha = 1
                    
                })
                
            } else if velocity.x > 500 {
                
                messageContainer.backgroundColor = green
                archiveImageView.alpha = 0
                
                UIView.animateWithDuration(0.3,
                    animations: {
                        self.messageView.frame.origin.x = self.messageView.frame.size.width
                        self.archiveImageView.transform = CGAffineTransformMakeTranslation(self.listView.frame.size.width - 60, 0)
                    },
                    completion: { _ in
                        UIView.animateWithDuration(0.9,
                            animations: {
                                self.messageContainer.transform = CGAffineTransformMakeTranslation(0, -self.messageContainer.frame.size.height)
                                self.feedImageView.transform = CGAffineTransformMakeTranslation(0, -self.messageView.frame.size.height)
                                self.listTableImageView.alpha = 0
                            },
                            completion: { _ in
                                self.messageContainer.removeFromSuperview()
                        })
                    }
                )
            
            } else if (160 <= translation.x) && (translation.x < 320) {
                
                messageContainer.backgroundColor = red
                deleteImageView.alpha = 0
                archiveImageView.alpha = 0
                
                UIView.animateWithDuration(0.1,
                    animations: {
                        self.messageView.frame.origin.x = self.messageView.frame.size.width
                        self.deleteImageView.transform = CGAffineTransformMakeTranslation(self.listView.frame.size.width - 60, 0)
                    },
                    completion: { _ in
                        UIView.animateWithDuration(0.9,
                            animations: {
                                self.messageContainer.transform = CGAffineTransformMakeTranslation(0, -self.messageContainer.frame.size.height)
                                self.feedImageView.transform = CGAffineTransformMakeTranslation(0, -self.messageView.frame.size.height)
                                self.listTableImageView.alpha = 0
                            },
                            completion: { _ in
                                self.messageContainer.removeFromSuperview()
                        })
                    }
                )
                
            } else if (-360 <= translation.x) && (translation.x < -260) {
                
                messageContainer.backgroundColor = brown
                UIView.animateWithDuration(0.9, animations: { () -> Void in
                    self.messageView.frame.origin.x = -self.messageView.frame.size.width
                    self.archiveImageView.alpha = 0
                    self.listTableImageView.alpha = 1
                })
                
            } else {
               
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.frame.origin = CGPointMake(0, 0)
                    self.laterImageView.transform = CGAffineTransformIdentity
                    self.archiveImageView.transform = CGAffineTransformIdentity
                    self.deleteImageView.transform = CGAffineTransformIdentity
                    self.listImageView.transform = CGAffineTransformIdentity
                })
            }
        }
    }
            
    @IBAction func onTapReschedule(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.feedImageView.transform = CGAffineTransformMakeTranslation(0, -self.messageView.frame.size.height)
            self.messageContainer.removeFromSuperview()
            self.rescheduleImageView.alpha = 0
        })
    }
    
    @IBAction func onTapListTableView(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.feedImageView.transform = CGAffineTransformMakeTranslation(0, -self.messageView.frame.size.height)
            self.messageContainer.removeFromSuperview()
            self.listTableImageView.alpha = 0
            
        })
    }
    
    @IBAction func onTapResetState(sender: UIButton) {
        self.listView.addSubview(self.messageContainer)
        self.listView.bringSubviewToFront(self.searchContainer)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.feedImageView.transform = CGAffineTransformIdentity
            self.messageContainer.transform = CGAffineTransformIdentity
            self.messageView.frame.origin = CGPointMake(0, 0)
            self.laterImageView.transform = CGAffineTransformIdentity
            self.archiveImageView.transform = CGAffineTransformIdentity
            self.deleteImageView.transform = CGAffineTransformIdentity
            self.listImageView.transform = CGAffineTransformIdentity
        })
    }
}

