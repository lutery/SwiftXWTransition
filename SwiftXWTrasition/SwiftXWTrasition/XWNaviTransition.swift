//
//  XWNaviTransition.swift
//  SwiftXWTrasition
//
//  Created by lutery on 16/8/8.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

enum XWNaviOneTransitionType {
    case Push, Pop
}

class XWNaviTransition: NSObject,UIViewControllerAnimatedTransitioning {
    
    var type:XWNaviOneTransitionType = XWNaviOneTransitionType.Push;

//    func transition(WithType type:XWNaviOneTransitionType) -> XWNaviTransition {
//        return
//    }

    init(WithType type:XWNaviOneTransitionType) {
        super.init();
        self.type = type;
    }
//    func init
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.type {
        case XWNaviOneTransitionType.Push:
            self.doPushAnimation(using: transitionContext);
        case XWNaviOneTransitionType.Pop:
            self.doPopAnimation(using: transitionContext);
        }
    }
    
    func doPushAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextFromViewControllerKey) as! XWMagicMoveController;
        let toVC = transitionContext.viewController(forKey: UITransitionContextToViewControllerKey) as! XWMagicMovePushController;
        
//        let cell = 
    }
    
    func doPopAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}
