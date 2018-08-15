//
//  DoubleExtension.swift
//  Let's Calc
//
//  Created by Demian Tejo on 5/23/17.
//  Copyright © 2017 Demian Tejo. All rights reserved.
//

import Foundation

extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    struct Number {
        static var formatter = NumberFormatter()
    }
    var scientificStyle: String {
        Number.formatter.numberStyle = .scientific
        Number.formatter.positiveFormat = "0.###E+0"
        Number.formatter.exponentSymbol = "e"
        return Number.formatter.string(from: self as NSNumber) ?? description
    }
}
