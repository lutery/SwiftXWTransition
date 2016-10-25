//
//  XWPageCoverController.swift
//  SwiftXWTrasition
//
//  Created by lutery on 2016/10/24.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

class XWPageCoverController: UIViewController, XWPageCoverPushControllerDelegate {
    
    var _interactiveTransitionPush:XWInteractiveTransition? = nil;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "翻页效果";
        self.view.backgroundColor = UIColor.gray;
        let imageView = UIImageView(image: UIImage(named: "pic2.jepg"));
        self.view.addSubview(imageView);
        imageView.frame = self.view.frame;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        
        let button = UIButton(type: .custom);
        button.setTitle("点我或向左滑动", for: .normal);
        button.setTitleColor(UIColor.white, for: .normal);
        self.view.addSubview(button);
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.addTarget(self, action: #selector(XWPageCoverController.push), for: .touchUpInside);
        self.view.addSubview(button);
        
        self._interactiveTransitionPush = XWInteractiveTransition(interactiveTransitionWithTransitionType: .Push, GestureDirection: .left);
        self._interactiveTransitionPush?.pushConifg = {
            self.push();
        };
        self._interactiveTransitionPush?.addPanGesture(ForViewController: self);
        
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true;
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true;
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        let centerX = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0);
        let topOffset = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 75);
        
        NSLayoutConstraint.activate([centerX, topOffset]);
        
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(XWPageCoverController.backToRoot));
        self.navigationItem.leftBarButtonItem = back;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func push(){
        let pushVC = XWPageCoverPushController();
        self.navigationController?.delegate = pushVC;
        pushVC._delegate = self;
        self.navigationController?.pushViewController(pushVC, animated: true);
    }
    
    func backToRoot(){
        self.navigationController?.delegate = nil;
        self.navigationController?.popViewController(animated: true);
    }
    
    func interactiveTransitionForPush() -> UIViewControllerInteractiveTransitioning {
        return self._interactiveTransitionPush!;
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
