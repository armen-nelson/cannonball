//
//  ViewController.swift
//  cannonball
//
//  Created by ArmenMac on 01.05.2023.
//

import UIKit
 

class ViewController: UIViewController {

    @IBOutlet weak var trajectoryView: TrajectoryView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var angleInput: UITextField!
    
    @IBOutlet weak var velocityInput: UITextField!
    
    @IBAction func showPressed(_ sender: UIButton) {

//        print("The initial Traj X \(trajectoryView.x)")
//        print("The initial Traj Y \(trajectoryView.y)")

        trajectoryView.g = 9.81
        trajectoryView.timeStep = 0.01
        
//        trajectoryView.x = 0.0
//        trajectoryView.y = 0.0
//
//        print("after nulling X \(trajectoryView.x)")
//        print("after nulling Y \(trajectoryView.y)")

        
        trajectoryView.clearTrajectory()
        
        

        
        if let xx = velocityInput.text, let yy = angleInput.text  {
                
 


            let velocity = Double(xx)!
            let angle = Double(yy)!
            
            if angle >= 90  {
                angleInput.text = ""
                angleInput.placeholder = "Input angle between 0 and 90 "
                
            } else if angle <= 0 {
                angleInput.text = ""
                angleInput.placeholder = "Input angle must be between 0 and 90 "
                
            } else
            {
                trajectoryView.timeElapsed = 0.0
                
                trajectoryView.initialVelocity = velocity
                trajectoryView.angleOfProjection = angle
                
                print("and the itinial velocity \(velocity) " )
                print("and the itinial angle \(angle) " )
            }
            
            
            

        } else {
           
            return
        }

        trajectoryView.drawTrajectory()
        
//         view.addSubview(trajectoryView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        
    }


}

