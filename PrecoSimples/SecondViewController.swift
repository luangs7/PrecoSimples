//
//  SecondViewController.swift
//  PrecoSimples
//
//  Created by Luan Silva on 20/06/17.
//  Copyright © 2017 Squarebits. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Objc


class SecondViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var margem: ACFloatingTextField!
    @IBOutlet weak var others: ACFloatingTextField!
    @IBOutlet weak var cobranca: ACFloatingTextField!
    @IBOutlet weak var aliquota: ACFloatingTextField!
    @IBOutlet weak var customercadoria: ACFloatingTextField!
    
    

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        btn.layer.cornerRadius = 2
        btn.clipsToBounds = true
        
        self.customercadoria.delegate = self
        self.aliquota.delegate = self
        self.cobranca.delegate = self
        self.margem.delegate = self
        self.others.delegate = self
       
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func saveObject(app: Appointment){
        var userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: app)
        userDefaults.set(encodedData, forKey: "appointment")
        userDefaults.synchronize()
        
        //        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "data") as! DataViewController
        //
        //        self.present(viewController, animated: true, completion: nil)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789.,").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }

  
    
    @IBAction func btnSubmit(_ sender: Any) {
        if !(customercadoria.text?.isEmpty)! || !(aliquota.text?.isEmpty)! || !(cobranca.text?.isEmpty)! ||  !(others.text?.isEmpty)! || !(margem.text?.isEmpty)!{
        let app = Appointment()
        
        app.custoServico = Double(customercadoria.text!)
        app.aliquotaSimples = Double(aliquota.text!)
        app.cobrancaPreco = Double(cobranca.text!)
        app.fretePreco = 0
        app.otherCost = Double(others.text!)
        app.margem = Double(margem.text!)
        
        saveObject(app: app)
        }else{
            let alertController = UIAlertController(title: "Erro", message: "Todos os campos devem ser preenchidos", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
                (result : UIAlertAction) -> Void in
                print("You pressed OK")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

   

}

