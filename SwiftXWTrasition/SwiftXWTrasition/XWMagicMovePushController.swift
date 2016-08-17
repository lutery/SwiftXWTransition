//
//  XWMagicMovePushController.swift
//  SwiftXWTrasition
//
//  Created by lutery on 16/8/8.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

class XWMagicMovePushController: UIViewController, UINavigationControllerDelegate {

    var imageView:UIImageView? = nil;
    var interactiveTransition:XWInteractiveTransition? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "神奇移动";
        self.view.backgroundColor = UIColor.white;
        let imageView = UIImageView(image: UIImage(named: "zrx4.jpg"));
        self.imageView = imageView;
        self.view.addSubview(imageView);
        imageView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - self.view.frame.height / 2 + 210);
        imageView.bounds = CGRect(x: 0, y: 0, width: 280, height: 280);
        let textView = UITextView.init();
        textView.translatesAutoresizingMaskIntoConstraints = false;
        textView.text = "这是类似KeyNote的神奇移动效果，向右滑动可以通过手势控制pop动画";
        textView.font = UIFont.systemFont(ofSize: 14);
        self.view.addSubview(textView);
        
        let viewsDictionary = ["imageView":imageView, "textView":textView];
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[textView]|", options: [], metrics: nil, views: viewsDictionary));
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]-0-[textView]-0-|", options: [], metrics: nil, views: viewsDictionary));
    
        self.interactiveTransition = XWInteractiveTransition.init(interactiveTransitionWithTransitionType: XWInteractiveType.Pop, GestureDirection: XWInteractiveDirection.right);
        
        self.interactiveTransition?.addPanGesture(ForViewController: self);
    }
    
    deinit {
        NSLog("销毁了");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        NSLog("％@", NSStringFromCGRect((self.imageView?.frame)!));
        
        return XWNaviTransition(WithType: operation == UINavigationControllerOperation.push ? XWNaviOneTransitionType.Push : XWNaviOneTransitionType.Pop);
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        var ret:UIViewControllerInteractiveTransitioning?  = nil;
        if interactiveTransition != nil {
            ret = (interactiveTransition?.interation)! ? interactiveTransition : nil;
        }
        return ret;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
