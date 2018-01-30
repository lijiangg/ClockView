//
//  ViewController.swift
//  闹钟绘制
//
//  Created by yurong on 2018/1/29.
//  Copyright © 2018年 yurong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var clockView: ClockView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnSelector(_ sender: UIButton) {
        
        clockView.currentPoint = 9;
        clockView.startAnimation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

