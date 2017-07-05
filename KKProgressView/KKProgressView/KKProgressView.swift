//
//  KKProgressView.swift
//  KKShapeLayer
//
//  Created by 王铁山 on 2017/3/14.
//  Copyright © 2017年 kk. All rights reserved.
//

import UIKit

public enum KKProgressViewStyle {
    
    case circle // 圆形
    
    case rectangle // 矩形
}

open class KKProgressView: UIView {
    
    open var style: KKProgressViewStyle = .circle
    
    /// 剩余部分的颜色 default is nil
    open var leftColor: UIColor? {
        didSet {
            self.setNeedsLayout()
        }
    }

    /// 当前进度 百分比
    open var progress: CGFloat = 0 {
        didSet {
            self.progressLayer?.strokeEnd = progress
            self.updateText()
        }
    }
    
    /// 是否展示文本进度
    open var showText: Bool = true {
        didSet {
            if self.showText {
                self.setLabel()
            } else {
                self.textLabel?.removeFromSuperview()
                self.textLabel = nil
            }
        }
    }
    
    /// 文本label
    open var textLabel: UILabel?
    
    /// 进度文本过滤，通过value得到字符，允许自定义
    open var filterText: ((_ value: CGFloat)->String)?
    
    /// 进度条颜色
    open var color: UIColor = UIColor.init(red: 76.0 / 255.0, green: 163.0 / 255.0, blue: 238.0 / 255.0, alpha: 1) {
        didSet {
            self.progressLayer?.strokeColor = self.color.cgColor
        }
    }
    
    /// 线宽
    open var lineWidth: CGFloat = 8 {
        didSet {
            self.progressLayer?.lineWidth = lineWidth
            self.refreshPath()
        }
    }
    
    /// 线顶头的形状
    /* The cap style used when stroking the path. Options are `butt', `round'
     * and `square'. Defaults to `butt'. */
    open var lineCap: String = "round" {
        didSet {
            self.progressLayer?.lineCap = self.lineCap
        }
    }

    fileprivate var progressLayer: CAShapeLayer?
    
    public init(frame: CGRect, style: KKProgressViewStyle) {
        super.init(frame: frame)
        
        self.style = style
        
        if self.style == .rectangle {
            self.lineCap = "square"
            self.showText = false
        }
        self.commitShapeLayer()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commitShapeLayer()
    }
    
    fileprivate func commitShapeLayer() {
        
        self.isOpaque = false
        
        let shapeLayer = CAShapeLayer.init()
        
        shapeLayer.fillColor = self.leftColor?.cgColor ?? UIColor.clear.cgColor
        
        shapeLayer.strokeColor = self.color.cgColor
        
        shapeLayer.lineWidth = self.lineWidth
        
        shapeLayer.lineCap = self.lineCap
        
        self.progressLayer = shapeLayer
        
        self.refreshPath()
        
        self.layer.addSublayer(shapeLayer)
        
        self.setLabel()
    }
    
    fileprivate func setLabel() {
        
        if self.textLabel == nil {
        
            let label = UILabel.init()
            
            label.textColor = UIColor.black
            
            label.font = UIFont.boldSystemFont(ofSize: 17)
            
            label.textAlignment = .center
            
            self.addSubview(label)
            
            self.textLabel = label
        }
    }
    
    fileprivate func updateText() {
        
        guard self.showText else {
            return
        }
        
        guard let filter = self.filterText else {
            
            self.textLabel?.text = String.init(format: "%d%%", Int(self.progress * 100))
            return
        }
        
        self.textLabel?.text = filter(self.progress)
    }
    
    fileprivate func refreshPath() {
        
        if self.style == .circle {
        
            let half = min(self.bounds.size.width / 2.0, self.frame.size.height / 2.0)
            
            let radius = half - self.lineWidth / 2.0
            
            let path = UIBezierPath.init()
            
            path.addArc(withCenter: CGPoint.init(x: half, y: half), radius: radius, startAngle: 0, endAngle: .pi * 2 + 0.1, clockwise: true)
            
            self.progressLayer?.path = path.cgPath
            
        } else if self.style == .rectangle {
            
            let path = UIBezierPath.init()
                        
            path.move(to: CGPoint.init(x: self.lineWidth / 2.0, y: self.frame.size.height / 2.0))
            
            path.addLine(to: CGPoint.init(x: self.frame.size.width - self.lineWidth / 2.0, y: self.frame.size.height / 2.0))
            
            self.progressLayer?.path = path.cgPath
        }
    }
    
    open override func layoutSubviews() {
        
        if let label = self.textLabel {
            label.sizeToFit()
            label.bounds = CGRect.init(x: 0, y: 0, width: self.frame.size.width - 2 * lineWidth - 10, height: label.bounds.size.height + 15)
            label.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.frame.size.height / 2.0)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()!
        
        // 圆形
        if self.style == .circle {
            
            if let cc = self.leftColor {
                
                let half = min(self.bounds.size.width / 2.0, self.frame.size.height / 2.0)
                
                let radius = half - self.lineWidth / 2.0
                
                context.addArc(center: CGPoint.init(x: half, y: half), radius: radius, startAngle: CGFloat(Double.pi * 2), endAngle: 0, clockwise: true)
                                
                context.setLineWidth(self.lineWidth)
                
                context.setStrokeColor(cc.cgColor)
                
                context.strokePath()
            }
        } else {
            
            if let cc = self.leftColor {
                
                let fillRect = CGRect.init(x: 0,
                                       y: self.frame.size.height / 2.0 - self.lineWidth / 2.0,
                                       width: self.frame.size.width,
                                       height: self.lineWidth)
                
                context.setFillColor(cc.cgColor)
                
                context.fill(fillRect)
            }
            
            
        }
    }
    
}
