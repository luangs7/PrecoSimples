//
//  Result.swift
//  PrecoSimples
//
//  Created by Luan Silva on 21/06/17.
//  Copyright © 2017 Squarebits. All rights reserved.
//

import Foundation



class Result: NSObject{
    
    var title: String?=""
    var percent: String?=""
    var value: String?=""
    override init() {
        
    }
    
    init(title:String, percent:String, value:String) {
        self.title = title
        self.percent = percent
        self.value = value
    }
    
    
}
