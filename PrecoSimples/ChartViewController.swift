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
    var option: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        appointment = getObject()
        setDataToArray(app: appointment!)
        
        let myDoubleString = String(format:"%.02f", (appointment?.toCalculate())! )
        
        total.text = myDoubleString

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
        
        results?.append(Result(title: app.option!, percent: " ", value: toString(number: app.custoMercadoria!)))
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
            if(strDouble != 0){
            entries.append(entry)
            }
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
        
    
        
        
        let pieChartDataSet = PieChartDataSet(values: entries, label: " ")
        pieChartDataSet.colors = colors
        pieChartDataSet.sliceSpace = 6
        pieChartDataSet.selectionShift = 10
        

        let data = PieChartData(dataSet: pieChartDataSet)
    
    
        let formatter = DefaultValueFormatter(formatter: formatCurrency())
        data.setValueFormatter(formatter)
        
        data.setValueFont(UIFont.boldSystemFont(ofSize: 11))
        data.setValueTextColor(UIColor.black)
        
    
        
        mChart.data = data

        mChart.noDataText = "Gráfico indisponível."
        // user interaction
        mChart.isUserInteractionEnabled = true
        
        let textColor = UIColor.black

    
        let center = NSMutableAttributedString()
        let numberText = NSMutableAttributedString(string: "TOTAL \n" , attributes: [NSForegroundColorAttributeName:textColor,NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])
        let descriptionText = NSMutableAttributedString(string: "R$", attributes: [NSForegroundColorAttributeName:textColor,NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])
        
        let valueText = NSMutableAttributedString(string: String(format:"%.02f", (appointment?.toCalculate())! ), attributes: [NSForegroundColorAttributeName:textColor,NSFontAttributeName: UIFont.boldSystemFont(ofSize: 22)])

        center.append(numberText)
        center.append(descriptionText)
        center.append(valueText)
        mChart.centerAttributedText = center
    
    }
    
    func formatCurrency() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2;
        formatter.locale = Locale(identifier: Locale.current.identifier)
        return formatter
//        let result = formatter.string(from: value as NSNumber);
//        return result!;
    }

    @IBAction func btnBack(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
