//
//  XWCircleSpreadTransition.swift
//  SwiftXWTrasition
//
//  Created by lutery on 2016/10/25.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

enum CircleSpreadType:NSInteger {
    case Present = 0
    case Dismiss
}

class XWCircleSpreadTransition: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    var _type:CircleSpreadType;
    
    init(_ type:CircleSpreadType) {
        self._type = type;
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch _type {
        case .Present:
            self.present(Animation: transitionContext);
            break;
            
        case .Dismiss:
            self.dismiss(Animation: transitionContext);
            break;
        }
    }
    
    func dismiss(Animation transitionContext:UIViewControllerContextTransitioning){
        let fromVC = transitionContext.viewController(forKey: .from);
        let toVC = transitionContext.viewController(forKey: .to) as! UINavigationController;
        
        let temp = toVC.viewControllers.last as! CircleSpreadController;
        let containerView = transitionContext.containerView;
        containerView.addSubview(toVC.view);
        
        let radius = sqrtf(Float(containerView.frame.size.height * containerView.frame.size.height) + Float(containerView.frame.size.width * containerView.frame.size.width)) / 2;
        let startCycle = UIBezierPath(arcCenter: containerView.center, radius: CGFloat(radius), startAngle: 0, endAngle: CGFloat(M_PI) * CGFloat(2), clockwise: true);
        let endCycle = UIBezierPath(ovalIn: temp.buttonFrame!);
        
        let maskLayer = CAShapeLayer();
        maskLayer.path = endCycle.cgPath;
        maskLayer.fillColor = UIColor.green.cgColor;
        fromVC?.view.layer.mask = maskLayer;
        containerView.addSubview((fromVC?.view)!);
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path");
        maskLayerAnimation.delegate = self;
        maskLayerAnimation.fromValue = startCycle.cgPath;
        maskLayerAnimation.toValue = endCycle.cgPath;
        maskLayerAnimation.duration = self.transitionDuration(using: transitionContext);
        maskLayerAnimation.delegate = self;
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        maskLayerAnimation.setValue(transitionContext, forKey: "transitionContext");
        maskLayer.add(maskLayerAnimation, forKey: "path");
    }
    
    func present(Animation transitionContext:UIViewControllerContextTransitioning){
        let fromVC = transitionContext.viewController(forKey: .from) as! UINavigationController;
        let toVC = transitionContext.viewController(forKey: .to);
        
        let temp = fromVC.viewControllers.last as! CircleSpreadController;
        let containerView = transitionContext.containerView;
        containerView.addSubview((toVC?.view)!);
        
        let startCycle = UIBezierPath(ovalIn: temp.buttonFrame!);
        let x:CGFloat = max((temp.buttonFrame?.origin.x)!, containerView.frame.size.width - (temp.buttonFrame?.origin.x)!);
        let y:CGFloat = max((temp.buttonFrame?.origin.x)!, containerView.frame.size.height - (temp.buttonFrame?.origin.y)!);
        let radius = sqrt(pow(x, 2) + pow(y, 2));
        let endCycle = UIBezierPath(arcCenter: containerView.center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI) * CGFloat(2), clockwise: true);
        let maskLayer = CAShapeLayer();
        maskLayer.path = endCycle.cgPath;
        toVC?.view.layer.mask = maskLayer;
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path");
        maskLayerAnimation.delegate = self;
        maskLayerAnimation.fromValue = startCycle.cgPath;
        maskLayerAnimation.toValue = endCycle.cgPath;
        maskLayerAnimation.duration = self.transitionDuration(using: transitionContext);
        maskLayerAnimation.delegate = self;
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        
        maskLayerAnimation.setValue(transitionContext, forKey: "transitionContext");
        maskLayer.add(maskLayerAnimation, forKey: "path");
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        switch self._type {
        case .Present:
            let transitionContext = anim.value(forKey: "transitionContext") as! UIViewControllerContextTransitioning;
//            transitionContext.completeTransition(true);
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled);
            break;
            
        case .Dismiss:
            let transitionContext = anim.value(forKey: "transitionContext") as! UIViewControllerContextTransitioning;
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled);
            if transitionContext.transitionWasCancelled{
                transitionContext.viewController(forKey: .from)?.view.layer.mask = nil;
            }
            break;
        }
    }
}
