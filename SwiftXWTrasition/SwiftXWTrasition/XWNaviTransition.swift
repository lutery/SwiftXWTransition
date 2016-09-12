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
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! XWMagicMoveController;
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! XWMagicMovePushController;
        
        let cell = fromVC.collectionView?.cellForItem(at: fromVC.currentIndexPath!) as! XWMagicMoveCell;
        let containerView = transitionContext.containerView;
        let tempView = cell.imageView.snapshotView(afterScreenUpdates: false);
        tempView?.frame = cell.imageView.convert(cell.imageView.bounds, to: containerView);
        
        cell.imageView.isHidden = true;
        toVC.view.alpha = 0;
        toVC.imageView?.isHidden = true;
        
        containerView.addSubview(toVC.view);
        containerView.addSubview(tempView!);
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1 / 0.55, options: UIViewAnimationOptions(rawValue: UInt(0)), animations: {
            tempView?.frame = (toVC.imageView?.convert((toVC.imageView?.bounds)!, to: containerView))!;
            toVC.view.alpha = 1;
            }, completion: {
                finished in
                tempView?.isHidden = true;
                toVC.imageView?.isHidden = false;
                transitionContext.completeTransition(true);
        })
    }
    
    func doPopAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! XWMagicMovePushController;
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! XWMagicMoveController;
        
        let cell = toVC.collectionView?.cellForItem(at: toVC.currentIndexPath!) as! XWMagicMoveCell;
        let containerView = transitionContext.containerView;
        
        let tempView = containerView.subviews.last! as UIView;
        
        cell.imageView.isHidden = true;
        fromVC.imageView?.isHidden = true;
        tempView.isHidden = false;
        
        containerView.insertSubview(toVC.view, at: 0);
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1 / 0.55, options: UIViewAnimationOptions(rawValue: UInt(0)), animations: {
            tempView.frame = cell.imageView.convert(cell.imageView.bounds, to: containerView);
            fromVC.view.alpha = 0;
            }, completion: {
                finished in
                transitionContext.completeTransition(!(transitionContext.transitionWasCancelled));
                if transitionContext.transitionWasCancelled {
                    tempView.isHidden = true;
                    fromVC.imageView?.isHidden = false;
                }
                else{
                    cell.imageView.isHidden = false;
                    tempView.removeFromSuperview();
                }
//                transitionContext.completeTransition(true);
        })
    }
}
