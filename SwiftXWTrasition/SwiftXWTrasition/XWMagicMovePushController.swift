//
//  XWMagicMovePushController.swift
//  SwiftXWTrasition
//
//  Created by lutery on 16/8/8.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit


/// 单元详细展示controller对象
class XWMagicMovePushController: UIViewController, UINavigationControllerDelegate {

    //图像控件
    var imageView:UIImageView? = nil;
    // 交互动画对象
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
        
        //控件数组
        let viewsDictionary = ["imageView":imageView, "textView":textView];
        //设置textView控件水平居中对齐
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[textView]|", options: [], metrics: nil, views: viewsDictionary));
        //设置imageView和textView垂直排列
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]-0-[textView]-0-|", options: [], metrics: nil, views: viewsDictionary));
        //初始化交互动画对象，这个交互动画适用的动作为pop动作，方向为向右
        self.interactiveTransition = XWInteractiveTransition.init(interactiveTransitionWithTransitionType: XWInteractiveType.Pop, GestureDirection: XWInteractiveDirection.right);
        //添加监控手势的Controller对象
        self.interactiveTransition?.addPanGesture(ForViewController: self);
    }
    
    deinit {
        NSLog("销毁了");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// 重载controller之间切换的交互动画
    ///
    /// - parameter navigationController: <#navigationController description#>
    /// - parameter operation:            <#operation description#>
    /// - parameter fromVC:               <#fromVC description#>
    /// - parameter toVC:                 <#toVC description#>
    ///
    /// - returns: <#return value description#>
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        NSLog("％@", NSStringFromCGRect((self.imageView?.frame)!));
        
        return XWNaviTransition(WithType: operation == UINavigationControllerOperation.push ? XWNaviOneTransitionType.Push : XWNaviOneTransitionType.Pop);
    }
    
    
    /// 重载controller之间切换时是否具备交互动作，如果具备返回实际的对象，这个返回的对象是让控制器具备交互动画的能力，否则返回空则表示控制器无法响应交互手势,这里貌似时设置默认的交互动画属性
    ///
    /// - parameter navigationController: <#navigationController description#>
    /// - parameter animationController:  <#animationController description#>
    ///
    /// - returns: <#return value description#>
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
