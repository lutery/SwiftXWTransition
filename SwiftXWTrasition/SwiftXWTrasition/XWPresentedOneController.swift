//
//  XWPresentedOneController.swift
//  SwiftXWTrasition
//
//  Created by lutery on 16/8/17.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

protocol XWPresentedOneControllerDelegate {
    func presentedOneControllerPressedDismiss();
    func interactiveTransitionForPresent() -> UIViewControllerInteractiveTransitioning?;
}

class XWPresentedOneController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var interactiveDismiss:XWInteractiveTransition? = nil;
    var interactivePush:XWInteractiveTransition? = nil;
    var delegate:XWPresentedOneControllerDelegate? = nil;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.layer.cornerRadius = 10;
        self.view.layer.masksToBounds = true;
        self.view.backgroundColor = UIColor.white;
        let textView = UITextView();
        textView.text = "warx";
        textView.font = UIFont.systemFont(ofSize: 16);
        textView.isEditable = false;
        self.view.addSubview(textView);
        
        let button = UIButton(type: .custom);
        button.setTitle("点我或向下滑动dismiss", for: .normal);
        button.setTitleColor(UIColor.black, for: .normal);
        self.view.addSubview(button);
        button.addTarget(self, action: #selector(XWPresentedOneController.btnDismiss), for: .touchUpInside);
        
        self.interactiveDismiss = XWInteractiveTransition(interactiveTransitionWithTransitionType: .Dismiss, GestureDirection: .down);
        self.interactiveDismiss?.addPanGesture(ForViewController: self);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnDismiss(){
        if self.delegate != nil{
            self.delegate?.presentedOneControllerPressedDismiss();
        }
    }
    
    func getInstance() -> XWPresentedOneController? {
        let conController:XWPresentedOneController? = XWPresentedOneController();
        if conController != nil {
            conController?.transitioningDelegate = self;
            conController?.modalPresentationStyle = .custom;
        }
        
        return conController;
    }
    
    deinit {
        print("销毁了");
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
