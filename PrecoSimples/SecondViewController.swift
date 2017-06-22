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
    
    var storeValue : NSMutableString = ""


    override func viewDidLoad() {
        storeValue = NSMutableString()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        super.viewDidLoad()

        btn.layer.cornerRadius = 2
        btn.clipsToBounds = true
        
        self.customercadoria.delegate = self
        self.aliquota.delegate = self
        self.cobranca.delegate = self
        self.margem.delegate = self
        self.others.delegate = self
       
        customercadoria.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        cobranca.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        others.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func clearString(text: String) -> String{
        var clear = text.replacingOccurrences(of: "R$", with: " ")
        clear = clear.replacingOccurrences(of: ",", with: ".")
        return clear
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
        
            
            app.custoMercadoria = NumberFormatter().number(from: clearString(text: customercadoria.text!))?.doubleValue
            app.aliquotaSimples = Double(aliquota.text!)
            app.cobrancaPreco = NumberFormatter().number(from: clearString(text: cobranca.text!))?.doubleValue
            app.otherCost = NumberFormatter().number(from: clearString(text: others.text!))?.doubleValue
            app.margem = Double(margem.text!)
            app.fretePreco = 0

        
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

   
    
    func myTextFieldDidChange(_ textField: ACFloatingTextField) {
        
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
}






