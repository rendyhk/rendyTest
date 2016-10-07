//
//  ViewController.swift
//  TestDC
//
//  Created by Rendy on 7/10/16.
//  Copyright © 2016 Rendy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var circleCenterPosition:CGPoint = CGPointZero

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightBtn = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(showAlert))
        self.navigationItem.rightBarButtonItem = rightBtn
        
        circleCenterPosition = CGPoint(x: view.center.x,y: view.center.y)
    }

    func showAlert() {
        let alert = UIAlertController(title: "Input", message: "Input Data", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Jumlah Item"
            textField.textAlignment = .Center
        }
        alert.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Radius"
            textField.textAlignment = .Center
        }
        let okAction = UIAlertAction(title: "OK", style: .Default){ action in
            self.createCircleView(Int(alert.textFields![0].text!) ?? 0, radius: Int(alert.textFields![1].text!) ?? 0)
        }
        
        alert.addAction(okAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func createCircleView(circleCount: Int, radius: Int) {
        view.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        //big circle
        makeCircle(CGFloat(radius), position: circleCenterPosition, color: UIColor.greenColor(), full:false)
        
        let rad = CGFloat(M_PI * 2) / CGFloat(circleCount)
        for i in 1...circleCount {
            var color = UIColor.blueColor()
            let radian = -M_PI_2
            if i == 1 {
                color = UIColor.greenColor()
            }
            makeCircle(10, position: getPosition(fromRadian: CGFloat(radian) + CGFloat(i-1) * rad, radius: CGFloat(radius)), color: color, full: true)
        }
    }
    
    func getPosition(fromRadian radian: CGFloat, radius:CGFloat) -> CGPoint  {
        let x = radius * CGFloat(cos(radian)) + circleCenterPosition.x
        let y = radius * CGFloat(sin(radian)) + circleCenterPosition.y
        return CGPointMake(CGFloat(x), CGFloat(y))
    }
    
    func makeCircle(radius: CGFloat, position: CGPoint, color: UIColor, full: Bool) {
        let circlePath = UIBezierPath(arcCenter: position, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        shapeLayer.fillColor = full ? color.CGColor :UIColor.clearColor().CGColor
        shapeLayer.strokeColor = color.CGColor
        shapeLayer.lineWidth = 3.0
        
        view.layer.addSublayer(shapeLayer)
    }


}

