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

class XWCircleSpreadTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
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
            break;
            
        case .Dismiss:
            break;
        }
    }
    
    func
}
