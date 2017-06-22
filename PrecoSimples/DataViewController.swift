//
//  DataViewController.swift
//  PrecoSimples
//
//  Created by Luan Silva on 20/06/17.
//  Copyright © 2017 Squarebits. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var tableResult: UITableView!
    
    var results : [Result]? = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableResult.delegate = self
        tableResult.dataSource = self
        
        let appointment = getObject()
        setDataToArray(app: appointment)
        
        let myDoubleString = String(format:"%.02f", appointment.toCalculate() )
        
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
    
    func setDataToArray(app: Appointment){
        
        results?.append(Result(title: "Custo da mercadoria", percent: " ", value: toString(number: app.custoMercadoria!)))
        results?.append(Result(title: "Aliquota simples", percent: toStringPercent(number: app.aliquotaSimples!), value: toString(number: Double(app.ruleOfThree(number: app.aliquotaSimples!)))))
        results?.append(Result(title: "Cobrança", percent: " ", value: toString(number: app.cobrancaPreco!)))
        results?.append(Result(title: "Frete", percent: " ", value: toString(number: app.fretePreco!)))
        results?.append(Result(title: "Outros custos", percent: " ", value: toString(number: app.otherCost!)))
        results?.append(Result(title: "Margem esperada", percent: toStringPercent(number: app.margem!), value: toString(number: Double(app.ruleOfThree(number: app.margem!)))))


    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellData", for: indexPath) as! BaseViewCell
        
        if ( indexPath.row < (self.results?.count)! ){
            cell.title.text = self.results?[indexPath.row].title
            cell.percent.text = self.results?[indexPath.row].percent
            cell.price.text = self.results?[indexPath.row].value
        }else{
            cell.title.text = nil
            cell.percent.text = nil
            cell.price.text = nil
        }
        

    
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( (self.results?.count)! < 7 ){
            return( 7 );
        }
        else{
            return( self.results!.count );
        }
    }
    

    func toString(number: Double) -> String{
        return String(format:"R$%.02f",number)
    }
    
    func toStringPercent(number: Double) -> String{
        var str = String(number)
        str = str + "%"
        
        return str
        
    }


}
