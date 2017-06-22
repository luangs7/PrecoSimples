//
//  Appointment.swift
//  PrecoSimples
//
//  Created by Luan Silva on 20/06/17.
//  Copyright © 2017 Squarebits. All rights reserved.
//

import Foundation

//
//  Appointment.swift
//  newsFeed
//
//  Created by Luan Silva on 19/06/17.
//  Copyright © 2017 Luan Silva. All rights reserved.
//

import UIKit

@objc(Appointment)
class Appointment: NSObject, NSCoding {
    var custoMercadoria: Double?=0
    var custoServico: Double?=0
    var aliquotaSimples: Double?=0
    var margem: Double?=0
    var fretePreco: Double?=0
    var cobrancaPreco: Double?=0
    var otherCost: Double?=0
    var option: String?=""
    
    override init(){
        
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        self.custoMercadoria = aDecoder.decodeObject(forKey:"custoMercadoria") as? Double
        self.custoServico = aDecoder.decodeObject(forKey: "custoServico") as? Double
        self.aliquotaSimples = aDecoder.decodeObject(forKey: "aliquotaSimples") as? Double
        self.margem = aDecoder.decodeObject(forKey: "margem") as? Double
        self.fretePreco = aDecoder.decodeObject(forKey: "fretePreco") as? Double
        self.cobrancaPreco = aDecoder.decodeObject(forKey: "cobrancaPreco") as? Double
        self.otherCost = aDecoder.decodeObject(forKey: "otherCost") as? Double
        self.option = aDecoder.decodeObject(forKey: "option") as? String

    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(self.custoMercadoria, forKey: "custoMercadoria")
        aCoder.encode(self.custoServico, forKey: "custoServico")
        aCoder.encode(self.aliquotaSimples, forKey: "aliquotaSimples")
        aCoder.encode(self.margem, forKey: "margem")
        aCoder.encode(self.fretePreco, forKey: "fretePreco")
        aCoder.encode(self.cobrancaPreco, forKey: "cobrancaPreco")
        aCoder.encode(self.otherCost, forKey: "otherCost")
        aCoder.encode(self.option, forKey: "option")

    }
    
    func toCalculate() -> Double{
        var cost: Double
        var costtwo: Double
        var aux1: Double
        var aux2: Double

        
        cost = self.custoMercadoria! + self.cobrancaPreco! + self.fretePreco! + self.otherCost!;
        aux1 = self.aliquotaSimples! / 100;
        aux2 = self.margem! / 100;
        costtwo = 1 - aux1 - aux2;
        cost = cost / costtwo;
        
        return cost
        
    }
    
    func ruleOfThree(number: Double) -> Float{
        var result: Double
        
        result = self.toCalculate() * number
        result = result / 100
        
        
        
        return convert(number: result)
    }
    
    
    func convert(number: Double) -> Float{
        var str: String = String(number)
        var num: Float = Float(str)!
        return num;
    }
    
}


