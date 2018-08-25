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
    
    func localizedAmount() -> String {
        let usLocale = Locale(identifier: "en_US")
        let usDecimalSeparator = usLocale.decimalSeparator!
        let usGroupingSeparator = usLocale.groupingSeparator!
        let formatter = NumberFormatter()
        formatter.locale = usLocale
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.usesGroupingSeparator = true
        guard let number = self.toDouble() else{
            return self
        }
        guard let result = formatter.string(from: number as NSNumber) else {
            return self
        }
        guard let decimalSeparator = Locale.current.decimalSeparator , let groupingSeparator = Locale.current.groupingSeparator else {
            return result
        }
        
        return result.replacingOccurrences(of: usDecimalSeparator, with: "@").replacingOccurrences(of: usGroupingSeparator, with: groupingSeparator).replacingOccurrences(of: "@", with: decimalSeparator)
    }
    
    func mathExpresionResult()-> String{
        var mathExpresion = self.replacingOccurrences(of: " ", with: "")
        mathExpresion = mathExpresion.replacingOccurrences(of: "÷", with: "/")
        mathExpresion = mathExpresion.replacingOccurrences(of: "x", with: "*")
        mathExpresion = mathExpresion.replacingOccurrences(of: "=", with: "")
        let expression = NSExpression(format: mathExpresion)
        let result = expression.expressionValue(with: nil, context: nil) as! Double
        if abs(result) > 100000000 {
            return "✕ Limit exceeded"
        }else{
            if String(describing: result).contains("."){
                return String(describing: result.roundTo(places: 2))
            }else{
                return String(describing: result)
            }
            
        }
    }


}
