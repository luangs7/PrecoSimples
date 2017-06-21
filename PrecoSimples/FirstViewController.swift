//
//  FirstViewController.swift
//  PrecoSimples
//
//  Created by Luan Silva on 20/06/17.
//  Copyright © 2017 Squarebits. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Objc


class FirstViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var custoMercadoria: ACFloatingTextField!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var margem: ACFloatingTextField!
    @IBOutlet weak var others: ACFloatingTextField!
    @IBOutlet weak var frete: ACFloatingTextField!
    @IBOutlet weak var cobranca: ACFloatingTextField!
    @IBOutlet weak var aliquota: ACFloatingTextField!
    

    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn.layer.cornerRadius = 2
        btn.clipsToBounds = true
        
        self.custoMercadoria.delegate = self
        self.aliquota.delegate = self
        self.cobranca.delegate = self
        self.frete.delegate = self
        self.margem.delegate = self
        self.others.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if !(custoMercadoria.text?.isEmpty)! || !(aliquota.text?.isEmpty)! || !(cobranca.text?.isEmpty)! || !(frete.text?.isEmpty)! || !(others.text?.isEmpty)! || !(margem.text?.isEmpty)!{
        let app = Appointment()
        
         app.custoMercadoria = Double(custoMercadoria.text!)
         app.aliquotaSimples = Double(aliquota.text!)
         app.cobrancaPreco = Double(cobranca.text!)
         app.fretePreco = Double(frete.text!)
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
    
}

