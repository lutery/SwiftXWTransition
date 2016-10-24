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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NSLog("销毁了");
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
