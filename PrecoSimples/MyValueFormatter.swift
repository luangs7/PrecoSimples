//
//  MyValueFormatter.swift
//  PrecoSimples
//
//  Created by Luan Silva on 22/06/17.
//  Copyright © 2017 Squarebits. All rights reserved.
//

import Foundation
import Charts

public class MyValueFormatter: NSObject, IAxisValueFormatter{
    

    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        return String(format: "R$%.02f", value)
    }
    
}
