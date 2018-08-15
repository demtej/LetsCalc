//
//  MathExpresion.swift
//  iToolkit
//
//  Created by Demian Tejo on 5/24/17.
//  Copyright © 2017 Demian Tejo. All rights reserved.
//

import UIKit



class MathExpresion: NSObject {

    private var terms : [Term] = [Term]()
    private var operators : [Operator] = [Operator]()
    private(set) var finished = false
    var result : String {
        get {
            if !finished {
                return ""
            }else{
                var stringRep = ""
                var index = 0
                for term in terms {
                    stringRep.append(term.stringRepresentation)
                    if operators.count > index {
                        stringRep.append(" " + operators[index].rawValue + " ")
                    }
                    index = index + 1
                }
                return (stringRep.mathExpresionResult() + " ").replacingOccurrences(of: ".0 ", with: " ")
            }
        }
    }
    var stringRepresentation: String {
        get {
            var stringRep = ""
            var index = 0
            for term in terms {
                stringRep.append(term.stringRepresentation)
                if operators.count > index {
                    stringRep.append(" " + operators[index].rawValue + " ")
                }
                index = index + 1
            }
            stringRep.append(" ")
            stringRep = stringRep.replacingOccurrences(of: ".0 ", with: " ")
            stringRep = stringRep.replacingOccurrences(of: ".0)", with: ")")
            stringRep.characters = stringRep.characters.dropLast()
            return stringRep
        }
    }
    var stringRepresentationWithResult: String {
        get {
            if !finished {
                return ""
            }
            var stringRep = self.stringRepresentation
            stringRep.append(" = " + stringRep.mathExpresionResult() + " ")
            stringRep = stringRep.replacingOccurrences(of: ".0 ", with: " ")
            stringRep = stringRep.replacingOccurrences(of: ".0)", with: ")")
            stringRep.characters = stringRep.characters.dropLast()
            return stringRep
        }
    }
    private init(terms:[Term],operators:[Operator]){
        self.terms = terms
        self.operators = operators
    }
    init(firstTerm : Term, firstOperator: Operator) {
        super.init()
        terms.append(firstTerm)
        operators.append(firstOperator)
    }
    public func add(term: Term, op:Operator? = nil){
        self.terms.append(term)
        if let oper = op {
            self.operators.append(oper)
        }else{
            self.finished = true
        }
    }
    public func createNotFinishedCopyWithOperator(_ op:Operator) -> MathExpresion {
        let mathExpresion = MathExpresion(terms: self.terms, operators: self.operators)
        mathExpresion.operators.append(op)
        return mathExpresion
    }
    
}

enum Operator {
    case PLUS
    case MINUS
    case INTO
    case TIMES
    
    var rawValue: String {
        switch self {
        case .PLUS: return "+"
        case .MINUS: return "-"
        case .INTO: return "÷"
        case .TIMES: return "x"
        }
    }
    
}

class Term : NSObject {
    private var doubleValue : Double
    private var negative : Bool = false
    var stringRepresentation : String {
        get {
            if (negative){
                return "(- " + String(doubleValue) + ")"
            }else{
                return String(doubleValue)
            }
        }
    }
    
    init(doubleValue : Double) {
        if doubleValue < 0 {
            self.doubleValue = doubleValue * -1
             self.negative = true
        }else{
            self.doubleValue = doubleValue
        }
       
    }
    
    func invertValue() {
        self.negative = !self.negative
    }
}
