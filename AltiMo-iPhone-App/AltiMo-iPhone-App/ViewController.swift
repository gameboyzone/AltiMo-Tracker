//
//  ViewController.swift
//  AltiMo-iPhone-App
//
//  Created by Student on 2/7/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit;
import CoreMotion;

class ViewController: UIViewController
{
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    
    @IBOutlet weak var motionActivityAvailable: UILabel!
    @IBOutlet weak var altitudeAvailable: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // **** Check if Altitude data is available ****
        
        //All sensors are available under CoreMotion library
        //CMAltimeter class retrieves data from Altimeter sensor. It's a static class
        
        altitudeAvailable.text = toString(CMAltimeter.isRelativeAltitudeAvailable());
        
        //If Altitude data is available, register a process to track altitude changes
        
        if(CMAltimeter.isRelativeAltitudeAvailable() == true)
        {
            NSLog("Altimeter Available");
            
            /*  The NSOperationQueue class regulates the execution of a set of NSOperation objects. After being added to a queue, an operation remains in that queue until it is explicitly canceled or finishes executing its task. An application may create multiple operation queues and submit operations to any of them. */
            
            CMAltimeter.startRelativeAltitudeUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { altitudeData, error in
                if(error != nil)
                {
                    self.altitudeLabel.text = toString(altitudeData.relativeAltitude) + " " + "m";
                }
            })
        }
        
        // **** Check if Motion activity is available ****
        
        motionActivityAvailable.text = toString(CMMotionActivityManager.isActivityAvailable());
        
        CMMotionActivityManager.startActivityUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { motionActivityData, error in
            if(error != nil)
            {
                self.altitudeLabel.text = toString(altitudeData.relativeAltitude) + " " + "m";
            }
        })
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning();
        
        // Dispose of any resources that can be recreated.
    }
    
}

