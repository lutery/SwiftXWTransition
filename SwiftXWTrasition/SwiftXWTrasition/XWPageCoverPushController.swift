//
//  XWPageCoverPushController.swift
//  SwiftXWTrasition
//
//  Created by lutery on 2016/10/24.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

protocol XWPageCoverPushControllerDelegate {
    func interactiveTransitionForPush() -> UIViewControllerInteractiveTransitioning;
}

class XWPageCoverPushController: UIViewController, UINavigationControllerDelegate {
    
    var _delegate:XWPageCoverPushControllerDelegate?;
    var _interactiveTransitionPop:XWInteractiveTransition?;
    var _operation:UINavigationControllerOperation?;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "翻页效果";
        self.view.backgroundColor = UIColor.gray;
        let imageView = UIImageView(image: UIImage(named: "pic1.jpg"));
        imageView.frame = self.view.frame;
        self.view.addSubview(imageView);
        
        let button = UIButton(type: .custom);
        button.setTitle("点我或向右滑动pop", for: .normal);
        button.setTitleColor(UIColor.white, for: .normal);
        self.view.addSubview(button);
        button.addTarget(self, action: #selector(XWPageCoverPushController.pop), for: .touchUpInside);
        
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        button.translatesAutoresizingMaskIntoConstraints = false;
        
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true;
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true;
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        let centerX = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0);
        let topOffset = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 75);
        
        NSLayoutConstraint.activate([centerX, topOffset]);
        
        self._interactiveTransitionPop = XWInteractiveTransition(interactiveTransitionWithTransitionType: .Pop, GestureDirection: .right);
        self._interactiveTransitionPop?.addPanGesture(ForViewController: self);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NSLog("销毁了");
    }
    
    func pop(){
        self.navigationController?.popViewController(animated: true);
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self._operation = operation;
        return XWPageCoverTransition(Transition: operation == UINavigationControllerOperation.push ? CoverTransitionType.push : CoverTransitionType.pop);
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        if self._operation == UINavigationControllerOperation.push {
            let interacitveTransitionPush:XWInteractiveTransition = self._delegate?.interactiveTransitionForPush() as! XWInteractiveTransition;
            return interacitveTransitionPush.interation ? interacitveTransitionPush : nil;
        }
        else{
            return (_interactiveTransitionPop?.interation)! ? _interactiveTransitionPop : nil;
        }
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
