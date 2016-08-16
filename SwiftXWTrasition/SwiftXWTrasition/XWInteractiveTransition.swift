//
//  XWInteractiveTransition.swift
//  SwiftXWTrasition
//
//  Created by lutery on 16/8/8.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

enum XWInteractiveDirection : NSInteger {
    case left = 0, right, up, down
}

enum XWInteractiveType : NSInteger {
    case Present = 0, Dismiss, Push, Pop
}

class XWInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var interation:Bool = false;
    var presentConifg:(()->Void)?;
    var pushConifg:(()->Void)?;
    
    weak var vc:UIViewController? = nil;
    var direction:XWInteractiveDirection?;
    var type:XWInteractiveType?;
    
    convenience init(interactiveTransitionWithTransitionType type:XWInteractiveType, GestureDirection direction:XWInteractiveDirection) {
        self.init(WithTransitionType: type, GestureDirection: direction);
    }
    
    init(WithTransitionType type:XWInteractiveType, GestureDirection direction:XWInteractiveDirection) {
        super.init();
        self.direction = direction;
        self.type = type;
    }
    
    func addPanGesture(ForViewController viewController:UIViewController){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(XWInteractiveTransition.handleGesture(_:)));
        self.vc = viewController;
        viewController.view.addGestureRecognizer(pan);
    }
    
    func handleGesture(_ panGesture:UIPanGestureRecognizer){
        var persent:CGFloat = 0;
        switch direction! {
        case XWInteractiveDirection.left:
            let transitionX = -panGesture.translation(in: panGesture.view).x;
            persent = transitionX / (panGesture.view?.frame.size.width)!;
            break
            
        case XWInteractiveDirection.down:
            let transitionX = panGesture.translation(in: panGesture.view).x;
            persent = transitionX / (panGesture.view?.frame.size.width)!;
            break;
            
        case XWInteractiveDirection.right:
            let transitionY = -panGesture.translation(in: panGesture.view).y;
            persent = transitionY / (panGesture.view?.frame.size.width)!;
            break;
            
        case XWInteractiveDirection.up:
            let transitionY = panGesture.translation(in: panGesture.view).y;
            persent = transitionY / (panGesture.view?.frame.size.height)!;
            break;
        }
        
        switch panGesture.state {
        case .began:
            self.interation = true;
            self.startGesture();
            break;
            
        case .changed:
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
    
    func startGesture(){
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
            self.vc?.navigationController?.popViewController(animated: true);
            break;
        }
    }
}
