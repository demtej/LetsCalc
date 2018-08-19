//
//  StringExtension.swift
//  Let's Calc
//
//  Created by Demian Tejo on 5/25/17.
//  Copyright © 2017 Demian Tejo. All rights reserved.
//

import Foundation


extension String {
    func toDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        return formatter.number(from: self)?.doubleValue
    }
    
    func mathExpresionResult()-> String{
        var mathExpresion = self.replacingOccurrences(of: " ", with: "")
        mathExpresion = mathExpresion.replacingOccurrences(of: "÷", with: "/")
        mathExpresion = mathExpresion.replacingOccurrences(of: "x", with: "*")
        mathExpresion = mathExpresion.replacingOccurrences(of: "=", with: "")
        let expression = NSExpression(format: mathExpresion)
        let result = expression.expressionValue(with: nil, context: nil) as! Double
        if result > 100000000 {
            return "ERROR"
                //String(describing: result.roundTo(places: 2).scientificStyle)
        }else{
            if String(describing: result).contains("."){
                return String(describing: result.roundTo(places: 2))
            }else{
                return String(describing: result)
            }
            
        }
    }


}
