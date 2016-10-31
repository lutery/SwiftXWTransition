//
//  CircleSpreadController.swift
//  SwiftXWTrasition
//
//  Created by lutery on 2016/10/26.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

class CircleSpreadController: UIViewController {
    
    var buttonFrame:CGRect?{
        get{
            return self.button?.frame;
        }
    };
    var button:UIButton? = nil;
    var buttonCenterX:NSLayoutConstraint?;
    var buttonCenterY:NSLayoutConstraint?;
    
    deinit {
        NSLog("销毁了");
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white;
        let imageView = UIImageView(image: UIImage(named: "pic2.jpeg"));
        self.view.addSubview(imageView);
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        
        let button = UIButton(type: .custom);
        self.button = button;
        button.setTitle("点击或\n拖动我", for: .normal);
        button.titleLabel?.numberOfLines = 0;
        button.titleLabel?.textAlignment = .center;
        button.contentHorizontalAlignment = .center;
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11);
        button.setTitleColor(UIColor.white, for: .normal);
        button.addTarget(self, action: #selector(CircleSpreadController.presented), for: .touchUpInside);
        button.backgroundColor = UIColor.gray;
        button.layer.cornerRadius = 20;
        button.layer.masksToBounds = true;
        self.view.addSubview(button);
        button.translatesAutoresizingMaskIntoConstraints = false;
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(CircleSpreadController.pan(Gesture:)));
        button.addGestureRecognizer(pan);
        
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true;
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true;
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        let buttonWidth = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40);
        let buttonHeight = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40);
        buttonCenterX = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0);
        buttonCenterY = NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0);
        
        NSLayoutConstraint.activate([buttonWidth, buttonHeight, buttonCenterX!, buttonCenterY!]);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presented(){
        let presentVC = CircleSpreadPresentedController();
        
        self.present(presentVC, animated: true, completion: nil);
    }
    
    func pan(Gesture pan:UIPanGestureRecognizer){
//        print(pan.location(in: self.view));
        button?.center = pan.location(in: self.view);
//        print(pan.translation(in: pan.view));
//        let button = pan.view;
//        var newCenter = CGPoint(x: pan.translation(in: pan.view).x + (button?.center.x)! - UIScreen.main.bounds.size.width / 2, y: pan.translation(in: pan.view).y + (button?.center.y)! - UIScreen.main.bounds.size.height / 2);
//        
//        print(pan.translation(in: pan.view).x + (button?.center.x)!);
//        print(newCenter);
//        buttonCenterX?.constant = newCenter.x;
//        buttonCenterY?.constant = newCenter.y;
        
//        button?.center.x += points.x + newCenter.x;
//        button?.center.y += points.y + newCenter.y;
////
//        button?.updateConstraints();
//        
//        pan.setTranslation(CGPoint.zero, in: pan.view);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
