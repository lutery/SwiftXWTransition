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
    var interation:Bool = true;
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
        
    }
}
