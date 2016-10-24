//
//  XWInteractiveTransition.swift
//  SwiftXWTrasition
//
//  Created by lutery on 16/8/8.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit


/// 交互方向
///
/// - left:  <#left description#>
/// - right: <#right description#>
/// - up:    <#up description#>
/// - down:  <#down description#>
enum XWInteractiveDirection : NSInteger {
    case left = 0, right, up, down
}


/// 交互动作
///
/// - Present: <#Present description#>
/// - Dismiss: <#Dismiss description#>
/// - Push:    <#Push description#>
/// - Pop:     <#Pop description#>
enum XWInteractiveType : NSInteger {
    case Present = 0, Dismiss, Push, Pop
}


/// 交互动作实现类
class XWInteractiveTransition: UIPercentDrivenInteractiveTransition {
    //是否具备交互动作
    var interation:Bool = false;
    //推出配置函数
    var presentConifg:(()->Void)?;
    //呈现配置函数
    var pushConifg:(()->Void)?;
    
    //弱引用UIViewController对象
    weak var vc:UIViewController? = nil;
    //当前交互的方向
    var direction:XWInteractiveDirection?;
    //当前交互的类型
    var type:XWInteractiveType?;
    
    
    /// 初始化函数
    ///
    /// - parameter type:      交互的类型
    /// - parameter direction: 交互的方向
    ///
    /// - returns: 返回实例对象
    convenience init(interactiveTransitionWithTransitionType type:XWInteractiveType, GestureDirection direction:XWInteractiveDirection) {
        self.init(WithTransitionType: type, GestureDirection: direction);
    }
    
    
    /// 初始化函数
    ///
    /// - parameter type:      交互的类型
    /// - parameter direction: 交互的方向
    ///
    /// - returns: 返回实例对象
    init(WithTransitionType type:XWInteractiveType, GestureDirection direction:XWInteractiveDirection) {
        super.init();
        self.direction = direction;
        self.type = type;
    }
    
    
    /// 添加手势监控
    ///
    /// - parameter viewController: 传入需要监控手势的Controller对象
    func addPanGesture(ForViewController viewController:UIViewController){
        //创建手势识别对象
        let pan = UIPanGestureRecognizer(target: self, action: #selector(XWInteractiveTransition.handleGesture(_:)));
        //添加控制器对象
        self.vc = viewController;
        //对控制器对象添加手势识别
        viewController.view.addGestureRecognizer(pan);
    }
    
    //手势识别响应函数
    func handleGesture(_ panGesture:UIPanGestureRecognizer){
        //当前移动距离与屏幕宽度的百分比
        var persent:CGFloat = 0;
        switch direction! {
        case XWInteractiveDirection.left:
            let transitionX = -panGesture.translation(in: panGesture.view).x;
            persent = transitionX / (panGesture.view?.frame.size.width)!;
            break
            
        case XWInteractiveDirection.right:
            let transitionX = panGesture.translation(in: panGesture.view).x;
            persent = transitionX / (panGesture.view?.frame.size.width)!;
            break;
            
        case XWInteractiveDirection.up:
            let transitionY = -panGesture.translation(in: panGesture.view).y;
            persent = transitionY / (panGesture.view?.frame.size.width)!;
            break;
            
        case XWInteractiveDirection.down:
            let transitionY = panGesture.translation(in: panGesture.view).y;
            persent = transitionY / (panGesture.view?.frame.size.height)!;
            break;
        }
        
        //根据当前的手势状态是调用相应的交互函数通知控制器进行相应交互的更新
        switch panGesture.state {
        case .began:
            self.interation = true;
            self.startGesture();
            break;
            
        case .changed:
            print("current Persent is \(persent)");
            self.update(persent);
            break;
            
        case .ended:
            self.interation = false;
            if persent > 0.5 {
                self.finish();
            }
            else{
                self.cancel();
            }
            break;
            
        default:
            break;
        }
    }
    
    
    /// 开始手势的动作
    func startGesture(){
        //根据当前交互的类型调用不同的函数
        //使控制器实现相应的动作，实现动作之后，之后系统会根据交互控制对象的函数协议进行相应的交互响应
        switch type! {
        case XWInteractiveType.Present:
            if presentConifg != nil {
                self.presentConifg!();
            }
            break;
            
        case XWInteractiveType.Dismiss:
            self.vc?.dismiss(animated: true, completion: nil);
            break;
            
        case XWInteractiveType.Push:
            if pushConifg != nil {
                self.pushConifg!();
            }
            break;
            
        case XWInteractiveType.Pop:
            print("XWInteractiveType.Pop");
            self.vc?.navigationController?.popViewController(animated: true);
            break;
        }
    }
}
