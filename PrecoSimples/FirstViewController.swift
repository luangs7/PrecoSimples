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
    
    var storeValue : NSMutableString = ""


    
    override func viewDidLoad() {
        storeValue = NSMutableString()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        super.viewDidLoad()
        
        btn.layer.cornerRadius = 2
        btn.clipsToBounds = true
        
        self.custoMercadoria.delegate = self
        self.aliquota.delegate = self
        self.cobranca.delegate = self
        self.frete.delegate = self
        self.margem.delegate = self
        self.others.delegate = self
        
        custoMercadoria.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        cobranca.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        frete.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        others.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if !(custoMercadoria.text?.isEmpty)! && !(aliquota.text?.isEmpty)! && !(cobranca.text?.isEmpty)! && !(frete.text?.isEmpty)! && !(others.text?.isEmpty)! && !(margem.text?.isEmpty)!{
        
        let app = Appointment()
            
         app.custoMercadoria = NumberFormatter().number(from: clearString(text: custoMercadoria.text!))?.doubleValue
         app.aliquotaSimples = Double(aliquota.text!)
         app.cobrancaPreco = NumberFormatter().number(from: clearString(text: cobranca.text!))?.doubleValue
         app.fretePreco = NumberFormatter().number(from: clearString(text: frete.text!))?.doubleValue
         app.otherCost = NumberFormatter().number(from: clearString(text: others.text!))?.doubleValue
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
    
    func clearString(text: String) -> String{
        var clear = text.replacingOccurrences(of: "R$", with: " ")
        clear = text.replacingOccurrences(of: ",", with: ".")
        return clear
    }
    
    func saveObject(app: Appointment){
        let userDefaults = UserDefaults.standard
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
    
    func myTextFieldDidChange(_ textField: ACFloatingTextField) {
        
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
  
    }
    
    
    

extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "R$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return "R$00.00"
        }
        
        return formatter.string(from: number)!
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

