//
//  ViewController.swift
//  SwiftXWTrasition
//
//  Created by lutery on 16/8/8.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var _data:NSArray{
        get{
            return ["神奇移动", "弹性", "翻页效果", "小圆点扩散"];
        }
    };
    var _viewControllers:NSArray{
        get{
            return ["XWMagicMoveController", "XWPresentOneController", "XWPageCoverController", "XWCircleSpreadController"];
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "自定义转场动画";
        self.navigationController?.view.layer.cornerRadius = 10;
        self.navigationController?.view.layer.masksToBounds = true;
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: nil, action: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func data() -> NSArray? {
//        if _data == nil {
//            _data = ["神奇移动", "弹性", "翻页效果", "小圆点扩散"];
//        }
//        
//        return _data;
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._data.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        
        cell?.textLabel?.text = _data[indexPath.row] as! String;
        
        return cell!;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(NSClassFromString(self._viewControllers[indexPath.row] as! String) as! UIViewController, animated: true);
    }
}

