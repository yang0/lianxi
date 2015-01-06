//
//  ViewController.swift
//  SwiftTest2
//
//  Created by 杨凌 on 15-1-6.
//  Copyright (c) 2015年 杨凌. All rights reserved.
//
//  1 演示xib的使用
//  2 对数组扩展新的方法
//  https://www.weheartswift.com/swifting-around/
//

import UIKit

class CustomTableViewCell : UITableViewCell {
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func loadItem(#title: String, image: String) {
        backgroundImage.image = UIImage(named: image)
        titleLabel.text = title
    }
}

//扩展array
extension Array {
    func each(callback: T -> ()) {
        for item in self {
            callback(item)
        }
    }
    
    func eachWithIndex(callback: (T, Int) -> ()) {
        var index = 0
        for item in self {
            callback(item, index)
            index += 1
        }
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
                            
    @IBOutlet var tableView: UITableView!
    
    var items: [(String, String)] = [
        ("❤", "swift 1.jpeg"),
        ("We", "swift 2.jpeg"),
        ("❤", "swift 3.jpeg"),
        ("Swift", "swift 4.jpeg"),
        ("❤", "swift 5.jpeg")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        addEffects()
        
        
        //load nib
        var nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "customCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customCell") as CustomTableViewCell
        
        // this is how you extract values from a tuple
        var (title, image) = items[indexPath.row]
        
        cell.loadItem(title: title, image: image)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        println("You selected cell #\(indexPath.row)!")
    }
    
    /*
    func addEffects() {
        [
            UIBlurEffect(style: UIBlurEffectStyle.Light),
            UIBlurEffect(style: UIBlurEffectStyle.Dark),
            UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
            ].eachWithIndex { (effect, index) in
                var effectView = UIVisualEffectView(effect: effect)
                
                effectView.frame = CGRectMake(0, CGFloat(50 * index), 320, 50)
                
                self.view.addSubview(effectView)
        }
    }*/
    
    //添加模糊效果
    func addEffects() {
        [
            UIBlurEffectStyle.Light,
            UIBlurEffectStyle.Dark,
            UIBlurEffectStyle.ExtraLight
            ].map {
                UIBlurEffect(style: $0)//先封装成UIBlurEffect对象
                
            }.eachWithIndex { (effect, index) in
                var effectView = UIVisualEffectView(effect: effect)
                
                effectView.frame = CGRectMake(0, CGFloat(50 * index), 320, 50)
                
                self.view.addSubview(effectView)
        }
    }
    
    
    




}

