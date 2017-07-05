//
//  KKAlertProgressView.swift
//  KKShapeLayer
//
//  Created by 王铁山 on 2017/4/22.
//  Copyright © 2017年 kk. All rights reserved.
//


import Foundation

import UIKit

/**
 *  类似弹框含有进度条的视图
 */
open class KKAlertProgressView: UIView {
    
    /// 是否展示期间背景灰色半透明
    open var dimsBackgroundDuringPresentation: Bool = true
    
    /// 进度条 view
    open var progressView: KKProgressView!
    
    /// 文本框
    open var textLabel: UILabel!
    
    /// content view
    open var contentView: UIView!
    
    /// 进度条和文本框的字体颜色
    open var commonColor: UIColor = UIColor.init(red: 76.0 / 255.0, green: 163.0 / 255.0, blue: 238.0 / 255.0, alpha: 1) {
        didSet {
            self.textLabel.textColor = commonColor
            self.progressView.color = commonColor
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        commitInitView()
    }
    
    public init() {
        super.init(frame: UIScreen.main.bounds)
        
        commitInitView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func commitInitView() {
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        self.addSubview(contentView)
        
        let pWidth = 100
        self.progressView = KKProgressView.init(frame: CGRect.init(x: 40, y: 20, width: pWidth, height: pWidth), style: .circle)
        contentView.addSubview(progressView)
        
        self.textLabel = UILabel()
        self.textLabel.textColor = commonColor
        self.textLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(textLabel)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = dimsBackgroundDuringPresentation ? UIColor.init(white: 0, alpha: 0.34) : UIColor.clear
        
        self.frame = CGRect.init(x: 0, y: 0,
                                 width: isLand ? screenSize.height : screenSize.width,
                                 height: isLand ? screenSize.width : screenSize.height)
        
        let contentWidth: CGFloat = 320 - 2 * 30
        let contentHeight: CGFloat = contentWidth * 160 / 229.0
        self.contentView.bounds = CGRect.init(x: 0, y: 0, width: contentWidth, height: contentHeight)
        self.contentView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0 + (isLand ? 0 : -30))
        
        self.progressView.center = CGPoint.init(x: contentView.bounds.size.width / 2.0, y: 25 + progressView.bounds.size.height / 2.0)
        
        textLabel.sizeToFit()
        textLabel.center = CGPoint.init(x: contentView.bounds.size.width / 2.0, y: contentView.bounds.size.height - 25)
    }
    
    /**
     更新进度
     
     - parameter progress: 进度
     */
    open func updateProgress(_ progress: CGFloat) {
        
        self.progressView.progress = min(progress, 1.0)
    }
    
    /**
     更新问富文本
     
     - parameter text: 富文本
     */
    open func updateAttributeText(_ text: NSAttributedString) {
        
        self.textLabel.attributedText = text
        textLabel.sizeToFit()
        textLabel.center = CGPoint.init(x: contentView.bounds.size.width / 2.0, y: contentView.bounds.size.height - 25)
    }
    
    /**
     更新文本
     */
    open func updateText(_ text: String) {
        
        self.textLabel.text = text
        textLabel.sizeToFit()
        textLabel.center = CGPoint.init(x: contentView.bounds.size.width / 2.0, y: contentView.bounds.size.height - 25)
    }
    
    /**
     展示
     */
    open func show() {
        
        func lastWindow() -> UIWindow? {
            return UIApplication.shared.keyWindow
        }
        
        guard let window = lastWindow() else {
            return
        }
        
        self.frame = window.bounds
        
        window.addSubview(self)
        
        self.alpha = 0
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
        }) 
    }
    
    /**
     消失
     */
    open func dismiss() {
        
        self.removeFromSuperview()
    }
    
}

extension KKAlertProgressView {
    
    fileprivate var screenSize: CGSize { return UIScreen.main.bounds.size }
    
    // 是否是横屏
    fileprivate var isLand: Bool {
        
        let interfaceOrientation = UIApplication.shared.statusBarOrientation
        
        return interfaceOrientation == .landscapeLeft || interfaceOrientation == .landscapeRight
    }
}


