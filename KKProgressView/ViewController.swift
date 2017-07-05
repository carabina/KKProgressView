//
//  ViewController.swift
//  KKProgressView
//
//  Created by 王铁山 on 2017/7/5.
//  Copyright © 2017年 king. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var alertProgressView: KKAlertProgressView!
    
    var progress: CGFloat = 0
    
    var progressView: KKProgressView!
    
    var progressView1: KKProgressView!
    
    var progressView2: KKProgressView!
    
    var progressView3: KKProgressView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // 有剩余颜色
        self.progressView1 = KKProgressView.init(frame: CGRect.init(x: 20, y: 20, width: 90, height: 90), style: .circle)
        self.view.addSubview(self.progressView1)
        self.progressView1.leftColor = UIColor.lightGray
        self.progressView1.color = UIColor.green
        
        
        // 进度，无剩余颜色
        self.progressView = KKProgressView.init(frame: CGRect.init(x: 120, y: 20, width: 90, height: 90), style: .circle)
        self.view.addSubview(self.progressView)
        
        // 进度，无剩余颜色
        self.progressView3 = KKProgressView.init(frame: CGRect.init(x: 220, y: 20, width: 90, height: 90), style: .circle)
        self.progressView3.showText = false
        self.view.addSubview(self.progressView3)
        
        // 矩形
        self.progressView2 = KKProgressView.init(frame: CGRect.init(x: 0, y: 520, width: 320, height: 25), style: .rectangle)
        self.progressView2.lineWidth = 25
        self.progressView2.leftColor = UIColor.lightGray
        self.view.addSubview(self.progressView2)

    }
    
    func refresh() {
        
        if self.progress > 1 {
            self.alertProgressView.updateText("提交成功 请等待返回结果")
            return
        }
        
        self.progress += 0.01
        
        self.progressView.progress = self.progress
        
        self.progressView1.progress = self.progress
        
        self.progressView2.progress = self.progress
        
        self.progressView3.progress = self.progress
        
        self.alertProgressView.updateProgress(self.progress)
        
        self.perform(#selector(refresh), with: nil, afterDelay: 0.05)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        alertProgressView = KKAlertProgressView()
        
        alertProgressView.updateText("正在提交...")
        
        alertProgressView.show()
        
        refresh()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

