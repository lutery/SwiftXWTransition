//
//  XWMagicMoveController.swift
//  SwiftXWTrasition
//
//  Created by lutery on 16/8/8.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class XWMagicMoveController: UICollectionViewController {

    var currentIndexPath:NSIndexPath? = nil;
    
    init() {
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: 150, height: 150);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        super.init(collectionViewLayout: layout);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
//        let layout = UICollectionViewFlowLayout

        self.title = "神奇移动";
        self.collectionView?.backgroundColor = UIColor.white;
        self.collectionView?.register(UINib(nibName: "XWMagicMoveCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier);
        let back = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(XWMagicMoveController.backToRoot));
        self.navigationItem.leftBarButtonItem = back;
        
        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 20
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndexPath = indexPath;
        let vc = XWMagicMovePushController();
        self.navigationController?.delegate = vc;
        self.navigationController?.pushViewController(vc, animated: true);
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: AnyObject?) {
    
    }
    */

    func backToRoot(){
        self.navigationController?.delegate = nil;
        self.navigationController?.popViewController(animated: true);
    }
}
