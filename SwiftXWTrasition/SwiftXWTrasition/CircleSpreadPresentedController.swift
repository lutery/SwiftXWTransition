//
//  CircleSpreadPresentedController.swift
//  SwiftXWTrasition
//
//  Created by lutery on 2016/10/26.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

class CircleSpreadPresentedController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var interactiveTransition:XWInteractiveTransition?;

    override func viewDidLoad() {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = .custom;
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.green;
        let imageView = UIImageView(image: UIImage(named: "pic1.jpg"));
        self.view.addSubview(imageView);
        imageView.frame = self.view.frame;
        
        let button = UIButton(type: .custom);
        button.setTitle("点我或向下滑动dismiss", for: .normal);
        button.addTarget(self, action: #selector(CircleSpreadPresentedController.dismissController), for: .touchUpInside);
        button.setTitleColor(UIColor.white, for: .normal);
        button.frame = CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: 50);
        self.view.addSubview(button);
        
        self.interactiveTransition = XWInteractiveTransition(interactiveTransitionWithTransitionType: XWInteractiveType.Dismiss, GestureDirection: XWInteractiveDirection.down);
        self.interactiveTransition?.addPanGesture(ForViewController: self);
    }
    
    deinit {
        NSLog("销毁了");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissController(){
        self.dismiss(animated: true, completion: nil);
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return XWCircleSpreadTransition.init(.Dismiss);
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return XWCircleSpreadTransition.init(.Present);
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (self.interactiveTransition?.interation)! ? self.interactiveTransition :  nil;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
