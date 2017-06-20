//
//  FirstViewController.swift
//  PrecoSimples
//
//  Created by Luan Silva on 20/06/17.
//  Copyright © 2017 Squarebits. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Objc


class FirstViewController: UIViewController {

    @IBOutlet weak var customercadoria: ACFloatingTextField!
    @IBOutlet weak var aliquota: ACFloatingTextField!
    @IBOutlet weak var cobranca: ACFloatingTextField!
    @IBOutlet weak var frete: ACFloatingTextField!
    @IBOutlet weak var others: ACFloatingTextField!
    @IBOutlet weak var margem: ACFloatingTextField!
    
    @IBOutlet weak var btn: UIButton!
    

    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn.layer.cornerRadius = 2
        btn.clipsToBounds = true

  
        
     
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnSubmit(_ sender: UIButton) {
        let app = Appointment()
        
         app.custoMercadoria = Double(customercadoria.text!)
         app.aliquotaSimples = Double(aliquota.text!)
         app.cobrancaPreco = Double(cobranca.text!)
         app.fretePreco = Double(frete.text!)
         app.otherCost = Double(others.text!)
         app.margem = Double(margem.text!)
        
         saveObject(app: app)
        
    }
    
    func saveObject(app: Appointment){
        var userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: app)
        userDefaults.set(encodedData, forKey: "appointment")
        userDefaults.synchronize()
        
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "data") as! DataViewController
        
        self.present(viewController, animated: true, completion: nil)
    }

}

