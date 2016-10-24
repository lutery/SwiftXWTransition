//
//  XWPageCoverTransition.swift
//  SwiftXWTrasition
//
//  Created by lutery on 2016/10/24.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

enum CoverTransitionType:NSInteger {
    case push = 0, pop
}

extension UIView{
    func setAnchorPoint(To point:CGPoint){
        self.frame = self.frame.offsetBy(dx: (point.x - self.layer.anchorPoint.x) * self.frame.size.width, dy: (point.y - self.layer.anchorPoint.y) * self.frame.size.height);
        self.layer.anchorPoint = point;
    }
}

class XWPageCoverTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var _type:CoverTransitionType;
    
    init(Transition type:CoverTransitionType) {
        self._type = type;
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self._type {
        case .push:
            break;
            
        case .pop:
            break;
        }
    }
    
    func doPushAnimation(_ transitionContext:UIViewControllerContextTransitioning){
        let fromVC = transitionContext.viewController(forKey: .from);
        let toVC = transitionContext.viewController(forKey: .to);
        
        let tempView = (fromVC?.view.snapshotView(afterScreenUpdates: false))! as UIView;
        tempView.frame = (fromVC?.view.frame)!;
        let containerView:UIView = transitionContext.containerView;
        containerView.addSubview((toVC?.view)!);
        containerView.addSubview(tempView);
        fromVC?.view.isHidden = true;
        containerView.insertSubview((toVC?.view)!, at: 0);
        tempView.setAnchorPoint(To: CGPoint(x: 0, y: 0.5));
        var transfrom3d = CATransform3DIdentity;
        transfrom3d.m34 = -0.002;
        containerView.layer.sublayerTransform = transfrom3d;
        
        let fromGradient = CAGradientLayer();
        fromGradient.frame = (fromVC?.view.bounds)!;
        fromGradient.colors = [UIColor.black.cgColor, UIColor.black.cgColor];
        
        fromGradient.startPoint = CGPoint(x: 0.0, y: 0.5);
        fromGradient.endPoint = CGPoint(x: 0.8, y: 0.5);
        let fromShadow = UIView.init(frame: (fromVC?.view.bounds)!);
        fromShadow.backgroundColor = UIColor.clear;
        fromShadow.layer.insertSublayer(fromGradient, at: 1);
        fromShadow.alpha = 0.0;
        tempView.addSubview(fromShadow);
        
        let toGradient = CAGradientLayer();
        toGradient.frame = (fromVC?.view.bounds)!;
        toGradient.colors = [UIColor.black.cgColor, UIColor.black.cgColor];
        toGradient.startPoint = CGPoint(x: 0.0, y: 0.5);
        toGradient.endPoint = CGPoint(x: 0.8, y: 0.5);
        let toShadow = UIView(frame: (fromVC?.view.bounds)!);
        toShadow.backgroundColor = UIColor.clear;
        toShadow.layer.insertSublayer(toGradient, at: 1);
        toShadow.alpha = 1.0;
        toVC?.view.addSubview(toShadow);
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            tempView.layer.transform = CATransform3DMakeRotation(-(CGFloat)(M_PI_2), 0, 1, 0);
            fromShadow.alpha = 1.0;
            toShadow.alpha = 0.0;
            }, completion: {
                finish in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled);
                if transitionContext.transitionWasCancelled {
                    tempView.removeFromSuperview();
                    fromVC?.view.isHidden = false;
                }
        })
    }
    
    func doPopAnimation(_ transitionContext:UIViewControllerContextTransitioning){
        let fromVC = transitionContext.viewController(forKey: .from);
        let toVC = transitionContext.viewController(forKey: .to);
        
        let containerView = transitionContext.containerView;
        let tempView = containerView.subviews.last;
        containerView.addSubview((toVC?.view)!);
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            tempView?.layer.transform = CATransform3DIdentity;
            fromVC?.view.subviews.last?.alpha = 1.0;
            tempView?.subviews.last?.alpha = 0.0;
            }, completion: {
                finish in
                if transitionContext.transitionWasCancelled {
                    transitionContext.completeTransition(false);
                }
                else{
                    transitionContext.completeTransition(true);
                    tempView?.removeFromSuperview();
                    toVC?.view.isHidden = false;
                }
        })
    }
}
