//
//  XWPresentOneTransition.swift
//  SwiftXWTrasition
//
//  Created by lutery on 16/8/17.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

enum PresentOneTransitionType {
    case Present
    case Dismiss
}

class XWPresentOneTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var type:PresentOneTransitionType? = nil;
    
    init(Type type:PresentOneTransitionType) {
        super.init();
        
        if self.type == nil {
            self.type = type;
        }
    }
    
    func transitionDuration(using transitionContext:UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.type == PresentOneTransitionType.Present ? 0.5 : 0.25;
    }
    
    func animateTransition(using transitionContext:UIViewControllerContextTransitioning) {
        switch (self.type)! {
        case PresentOneTransitionType.Present:
            self.present(Animation: transitionContext);
            
        case PresentOneTransitionType.Dismiss:
            self.dismiss(Animation: transitionContext);
        }
    }
    
    func present(Animation transitionContext:UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to);
        let fromVC = transitionContext.viewController(forKey: .from);
        
        let tempView = fromVC!.view.snapshotView(afterScreenUpdates: false)! as UIView;
        tempView.frame = (fromVC?.view.frame)!;
        fromVC?.view.isHidden = true;
        
        let containerView = transitionContext.containerView;
        containerView.addSubview(tempView);
        containerView.addSubview((toVC?.view)!);
        
        toVC?.view.frame = CGRect(x: 0, y: containerView.bounds.height, width: containerView.bounds.width, height: 400);
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1.0 / 0.55, options: UIViewAnimationOptions(rawValue: UInt(0)), animations: {
            toVC?.view.transform = CGAffineTransform(translationX: 0, y: -400);
            tempView.transform = CGAffineTransform(scaleX: 0.85, y: 0.85);
            }, completion: {
                finish in
                transitionContext.completeTransition(!(transitionContext.transitionWasCancelled));
                if transitionContext.transitionWasCancelled {
                    fromVC?.view.isHidden = false;
                    tempView.removeFromSuperview();
                }
//                if transitionContext.transitionWasCancelled {
//                    transitionContext.completeTransition(false);
//                }
//                else{
//                    transitionContext.completeTransition(true);
//                    toVC?.view.isHidden = false;
//                    tempView.removeFromSuperview();
//                }
        })
    }
    
    func dismiss(Animation transitionContext:UIViewControllerContextTransitioning){
        let toVC = transitionContext.viewController(forKey: .to);
        let fromVC = transitionContext.viewController(forKey: .from);
        
        let containerView = [transitionContext.containerView];
        let subViewsArray = containerView[0].subviews;
        let tempView = subViewsArray[min(subViewsArray.count, max(0, subViewsArray.count - 2))];
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromVC?.view.transform = CGAffineTransform.identity;
            tempView.transform = CGAffineTransform.identity;
            }, completion: {
                finish in
                if transitionContext.transitionWasCancelled{
                    transitionContext.completeTransition(false);
                }
                else{
                    transitionContext.completeTransition(true);
                    toVC?.view.isHidden = false;
                    tempView.removeFromSuperview();
                }
        })
    }
}
