//
//  TrajectoryView.swift
//  cannonball
//
//  Created by ArmenMac on 01.05.2023.
//

import Foundation
import UIKit


//class TrajectoryView: UIView {
//    var angle: Double = 45.0
//    var velocity: Double = 50.0
//    let g = 9.8 // Acceleration due to gravity
//    let timeStep = 0.1 // Time step for numerical integration
//    var timeSteps: [Double] = []
//    var maxY: CGFloat = 0.0
//
//    override func draw(_ rect: CGRect) {
//        // Apply a vertical flip transformation
//        let context = UIGraphicsGetCurrentContext()!
//        context.translateBy(x: 0, y: bounds.height)
//        context.scaleBy(x: 1, y: -1)
//
//        // Create a new path for the trajectory
//        let trajectoryPath = UIBezierPath()
//
//        // Calculate the initial velocity components
//        let v0x = velocity * cos(angle * Double.pi / 180.0)
//        let v0y = velocity * sin(angle * Double.pi / 180.0)
//
//        // Calculate the maximum height and total flight time
//        let hmax = pow(v0y, 2.0) / (2.0 * g)
//        let tmax = 2.0 * v0y / g
//
//        // Add the initial point to the trajectory path
//        trajectoryPath.move(to: CGPoint(x: 0.0, y: CGFloat(hmax)))
//        timeSteps.append(0.0)
//
//        // Integrate the trajectory using the time step
//        var t = 0.0
//        var x = 0.0
//        var y = hmax
//        while y >= 0.0 {
//            t += timeStep
//            let vx = v0x
//            let vy = v0y - g * t
//            x += vx * timeStep
//            y = hmax + vy * t - 0.5 * g * pow(t, 2.0)
//            trajectoryPath.addLine(to: CGPoint(x: x, y: CGFloat(y)))
//            timeSteps.append(t)
//        }
//
//        // Calculate the maximum y value of the trajectory
//        maxY = trajectoryPath.bounds.maxY
//
//        // Apply a horizontal flip transformation
//        context.scaleBy(x: -1, y: 1)
//        context.translateBy(x: -bounds.width, y: 0)
//
//        // Apply a scaling transformation
//        let scaleFactor = bounds.width / (CGFloat(tmax) * CGFloat(v0x))
//        context.scaleBy(x: scaleFactor, y: -scaleFactor)
//        context.translateBy(x: 0, y: -maxY)
//
//        // Draw the trajectory path
//        trajectoryPath.stroke()
//    }
//}

//@IBDesignable // это чтобы сразу отрисовывалось , чтобы не запускать!!! КРУТО!

class TrajectoryView: UIView {
    
  
    var initialVelocity: Double = 0.0
    var angleOfProjection: Double = 0.0
    var g: Double = 9.81
    var timeStep: Double = 0.01
    
    private var path = UIBezierPath()
    
    var timeElapsed: Double = 0.0
     var x: Double = 0.0
         var y: Double = 0.0
    private var horizontalVelocity: Double = 0.0
    private var verticalVelocity: Double = 0.0
    private var timer: Timer?
    

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        
        // Apply a vertical flip transformation
        context.translateBy(x: 0, y: bounds.height)
        context.scaleBy(x: 1, y: -1)
        
        // Set up X and Y axis
        let xAxis = UIBezierPath()
        xAxis.move(to: CGPoint(x: 0, y: 0))
        xAxis.addLine(to: CGPoint(x: bounds.width, y: 0))
        xAxis.lineWidth = 2.0
        UIColor.gray.setStroke()
        xAxis.stroke()
        
        let yAxis = UIBezierPath()
        yAxis.move(to: CGPoint(x: 0, y: 0))
        yAxis.addLine(to: CGPoint(x: 0, y: bounds.height))
        yAxis.lineWidth = 2.0
        UIColor.gray.setStroke()
        yAxis.stroke()
        
        UIColor.red.setStroke()
        path.lineWidth = 2.0
        
        
        
        // Scale the context to fit the trajectory within the view's bounds
        let scale = bounds.width / CGFloat(x)
        context.scaleBy(x: scale, y: scale)
        
        path.stroke()
    }
    
    func drawTrajectory() {
        // Clear the path
   
        
        
        path.removeAllPoints()
        
        
        // Initialize variables and move to the starting point
        horizontalVelocity = initialVelocity * cos(angleOfProjection * Double.pi / 180.0)
        verticalVelocity = initialVelocity * sin(angleOfProjection * Double.pi / 180.0)

        print("The vertical velocity is: \(verticalVelocity)" )
        print("The horizontal velocity is: \(horizontalVelocity)" )
      
      
        path.move(to: CGPoint(x: 0, y: 0))
        
        // Start the timer to update the path
        timer = Timer.scheduledTimer(timeInterval: timeStep*0.2, target: self, selector: #selector(updatePath), userInfo: nil, repeats: true)
    }
    
    
    func clearTrajectory() {
        
        path.removeAllPoints()
 setNeedsDisplay()
       
    }
    
    @objc private func updatePath() {

        
        
        timeElapsed += timeStep
        
        
        x = horizontalVelocity * timeElapsed
     y = verticalVelocity * timeElapsed - 0.5 * g * timeElapsed * timeElapsed
        
        print("x is \(x)")
        print("y is \(y)")

        guard !x.isNaN && !y.isNaN else {
                print("Invalid calculation. x or y is NaN.")
                return
            }
        
         let point = CGPoint(x: x, y: y)
        
            path.addLine(to: point)
            setNeedsDisplay()

       
        if y <= 0 {
            
            timer?.invalidate()

           let maxHeight = (verticalVelocity + sqrt(verticalVelocity * verticalVelocity + 2 * g * y)) / g
               let maxDistance = horizontalVelocity * maxHeight

            print("Maximum height: \(maxHeight)")
            print("Distance: \(maxDistance)")

            //
//            guard !t.isNaN && !d.isNaN else {
//                      print("Invalid calculation. t or d is NaN.")
//                t = 0
//                d = 0
//                      return
//                  }
//
            
        }
    }
    
}
