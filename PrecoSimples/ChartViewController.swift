//
//  ChartViewController.swift
//  PrecoSimples
//
//  Created by Luan Silva on 22/06/17.
//  Copyright © 2017 Squarebits. All rights reserved.
//

import UIKit
import Charts



class ChartViewController: UIViewController {
    
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var mChart: PieChartView!
    
    var appointment : Appointment?
    var results : [Result]? = []
    var chart : PieChartView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        appointment = getObject()
        setDataToArray(app: appointment!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        generateChart()
    }

    
    func toString(number: Double) -> String{
        return String(format:"%.02f",number)
    }
    
    func toStringPercent(number: Double) -> String{
        var str = String(number)
        str = str + "%"
        
        return str
        
    }
    
    func generateChart(){
        var entries = [PieChartDataEntry]()
        for index in 0..<results!.count {
            let str = results![index].value
            let strDouble = NumberFormatter().number(from: str!)?.doubleValue
            let entry = PieChartDataEntry(value: (strDouble)!, label: results![index].title)
            entries.append(entry)
        }
        
        // this is custom extension method. Download the code for more details.
        var colors: [UIColor] = []
        
    
        for c in ChartColorTemplates.vordiplom() {
            colors.append(c)
        }
        
        for c in ChartColorTemplates.joyful(){
            colors.append(c)
        }
        for c in ChartColorTemplates.colorful(){
            colors.append(c)
        }
        for c in ChartColorTemplates.liberty(){
            colors.append(c)
        }
        for c in ChartColorTemplates.pastel(){
            colors.append(c)
        }
        
    
        let pieChartDataSet = PieChartDataSet(values: entries, label: "Preço Simples")
        pieChartDataSet.colors = colors

        let data = PieChartData(dataSet: pieChartDataSet)
        mChart.data = data
        mChart.noDataText = "No data available"
        // user interaction
        mChart.isUserInteractionEnabled = true
        
    }

}
