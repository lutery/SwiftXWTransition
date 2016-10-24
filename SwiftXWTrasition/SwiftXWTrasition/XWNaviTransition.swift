//
//  XWNaviTransition.swift
//  SwiftXWTrasition
//
//  Created by lutery on 16/8/8.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit


/// 切换动作枚举
///
/// - Push: 展现
/// - Pop:  弹出
enum XWNaviOneTransitionType {
    case Push, Pop
}


/// 切换动画协议
class XWNaviTransition: NSObject,UIViewControllerAnimatedTransitioning {
    
    //默认是展现动画
    var type:XWNaviOneTransitionType = XWNaviOneTransitionType.Push;

//    func transition(WithType type:XWNaviOneTransitionType) -> XWNaviTransition {
//        return
//    }

    init(WithType type:XWNaviOneTransitionType) {
        super.init();
        self.type = type;
    }
//    func init
    
    
    /// 实现协议，动画的时间
    ///
    /// - parameter transitionContext: <#transitionContext description#>
    ///
    /// - returns: 返回动画的时间，以秒为单位
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75;
    }
    
    
    /// 实现实际动画动作的协议
    ///
    /// - parameter transitionContext: <#transitionContext description#>
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.type {
        case XWNaviOneTransitionType.Push:
            self.doPushAnimation(using: transitionContext);
        case XWNaviOneTransitionType.Pop:
            self.doPopAnimation(using: transitionContext);
        }
    }
    
    
    /// 实现动作动作的函数，供协议调用
    ///
    /// - parameter transitionContext: <#transitionContext description#>
    func doPushAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        //获取fromvc以及tovc两个controller对象
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! XWMagicMoveController;
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! XWMagicMovePushController;
        
        //从fromvc上获取cell单元对象
        let cell = fromVC.collectionView?.cellForItem(at: fromVC.currentIndexPath!) as! XWMagicMoveCell;
        //获取上下文view容器对象
        let containerView = transitionContext.containerView;
        //获取imageview的快照对象
        let tempView = cell.imageView.snapshotView(afterScreenUpdates: false);
        //转换imageView在fromvc上的坐标位置到tovc上面相应的坐标系上面的位置
        tempView?.frame = cell.imageView.convert(cell.imageView.bounds, to: containerView);
        
        cell.imageView.isHidden = true;
        toVC.view.alpha = 0;
        toVC.imageView?.isHidden = true;
        
        //将toVC以及tempView添加到容器上面
        containerView.addSubview(toVC.view);
        containerView.addSubview(tempView!);
        
        //开始执行动画
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1 / 0.55, options: UIViewAnimationOptions(rawValue: UInt(0)), animations: {
            //设置view目标的转换属性
            //将tempview大小转换为tovc上面imageview 控件的大小
            //将tovc.view的透明度改为1，使其能够显示
            tempView?.frame = (toVC.imageView?.convert((toVC.imageView?.bounds)!, to: containerView))!;
            toVC.view.alpha = 1;
            }, completion: {
                //设置完成的时候目标view的属性，显示或者隐藏相应的UIView，并通知上下文动画完成事件
                finished in
                tempView?.isHidden = true;
                toVC.imageView?.isHidden = false;
                transitionContext.completeTransition(true);
        })
    }
    
    
    /// 实现退出动画动作，供协议调用，原理同上
    ///
    /// - parameter transitionContext: <#transitionContext description#>
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
