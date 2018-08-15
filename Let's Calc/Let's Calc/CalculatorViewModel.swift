//
//  CalculatorViewModel.swift
//  Let's Calc
//
//  Created by Demian Tejo on 5/27/17.
//  Copyright © 2017 Demian Tejo. All rights reserved.
//

import Foundation

class CalculatorViewModel : NSObject {
    var mathExpresions = [MathExpresion]()
    var currentMathExpresion : MathExpresion?
    weak var viewController : CalculatorViewController?
    var currentInput : String
    
    init(viewController : CalculatorViewController?) {
        self.viewController = viewController
        self.currentInput = ""
    }
    
    func doAction(_ action: Action, operatorValue : Operator?, digit : String? ) {
        if let currentExpresion = self.currentMathExpresion {
            if currentExpresion.finished {
                if let op = operatorValue , let doubleValue = self.currentMathExpresion?.result.toDouble() {
                    self.currentMathExpresion = nil
                    appendToCurrentExpresion(term: Term(doubleValue: doubleValue), op: op)
                    guard let controller = viewController else {
                        return
                    }
                    controller.updateViews()
                    return
                }else{
                    self.currentInput = ""
                }
            }
        }
        switch action {
        case Action.NUMBER:
            guard let digit = digit else {
                return
            }
            self.currentInput.append(digit)
        case Action.MINUS,Action.PLUS,Action.INTO,Action.TIMES:
            guard let op = operatorValue , let doubleValue = self.currentInput.toDouble() else{
                return
            }
            appendToCurrentExpresion(term: Term(doubleValue: doubleValue), op: op)
        case Action.NEGATIVE_POSITIVE:
            self.invertValueOfCurrentInput()
        case Action.CLEAR:
            self.currentInput = ""
            self.currentMathExpresion = nil
        case Action.DOT:
            guard let digit = digit else {
                return
            }
            if !self.currentInput.contains(digit){
                self.currentInput.append(digit)
            }
        case Action.PERCENT:
            guard let doubleValue = Double(self.currentInput) else{
                return
            }
            self.currentInput =  String((doubleValue / 100))
        case Action.DELETE:
            self.currentInput.characters = self.currentInput.characters.dropLast()
            if self.currentInput == "-" {
                self.currentInput = ""
            }
        case Action.EQUALS:
            guard let doubleValue = self.currentInput.toDouble() , let expresion = self.currentMathExpresion else{
                return
            }

            expresion.add(term: Term(doubleValue: doubleValue))
            self.mathExpresions.append(expresion)
            
        }
        guard let controller = viewController else {
            return
        }
        controller.updateViews()
    }
    
    func appendToCurrentExpresion(term: Term, op:Operator){
        if self.currentMathExpresion == nil {
            self.currentMathExpresion = MathExpresion(firstTerm: term, firstOperator: op)
        }else{
            self.currentMathExpresion?.add(term: term, op: op)
        }
        self.currentInput = ""
    }
    
    func invertValueOfCurrentInput(){
        if (self.currentInput.contains(".")){
            guard let doubleValue = Double(self.currentInput) else{
                return
            }
            self.currentInput =  String((doubleValue * (-1)))
        }else{
            guard let intValue = Int(self.currentInput) else{
                return
            }
            self.currentInput =  String( intValue * (-1))
        }
    }
    
    
}
