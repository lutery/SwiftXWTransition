//
//  XWPresentOneController.swift
//  SwiftXWTrasition
//
//  Created by lutery on 16/8/17.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

class XWPresentOneController: UIViewController, XWPresentedOneControllerDelegate {
    
    var interactivePush:XWInteractiveTransition? = nil;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "弹性Present";
        self.view.backgroundColor = UIColor.white;
        let imageView = UIImageView(image: UIImage.init(named: "zrx3.jpg"));
        imageView.layer.cornerRadius = 10;
        imageView.layer.masksToBounds = true;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(imageView);
        
        let button = UIButton(type: .custom);
        button.setTitle("点我或者向上滑动present", for: .normal);
        self.view.addSubview(button);
        button.setTitleColor(UIColor.black, for: .normal);
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.addTarget(self, action: #selector(XWPresentOneController.btnPresent), for: .touchUpInside);
        
        interactivePush = XWInteractiveTransition(WithTransitionType: .Present, GestureDirection: .up);
        weak var weakSelf = self;
        interactivePush?.presentConifg = {
            weakSelf?.btnPresent();
        };
        interactivePush?.addPanGesture(ForViewController: self.navigationController!);
        
        let viewsDictionary = ["imageView":imageView, "button":button];
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView(250)]|", options: [], metrics: nil, views: viewsDictionary));
//        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[textView]|", options: [], metrics: nil, views: viewsDictionary));
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[imageView(250)-10-[button]]|", options: [NSLayoutFormatOptions.alignAllCenterX], metrics: nil, views: viewsDictionary));
//
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnPresent(){
        let presentedVC = XWPresentedOneController();
        presentedVC.delegate = self;
        self.present(presentedVC, animated: true, completion: nil);
    }
    
    func presentedOneControllerPressedDismiss() {
        self.dismiss(animated: true, completion: nil);
    }
    
    func interactiveTransitionForPresent() -> UIViewControllerInteractiveTransitioning? {
        return self.interactivePush;
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
