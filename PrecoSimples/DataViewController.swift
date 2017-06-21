//
//  DataViewController.swift
//  PrecoSimples
//
//  Created by Luan Silva on 20/06/17.
//  Copyright © 2017 Squarebits. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
  
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var tableResult: UITableView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       let appointment = getObject()
        
        let myDoubleString = String(describing: appointment.toCalculate() )
        
        total.text = myDoubleString
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnBack(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func getObject() -> Appointment{
        
            var userDefaults = UserDefaults.standard
        
            if let data = userDefaults.object(forKey: "appointment") as? NSData {
                let app = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! Appointment
                return app
            }else{
                return Appointment()
        }
    }

}
