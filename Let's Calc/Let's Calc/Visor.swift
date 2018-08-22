//
//  Visor.swift
//  Let's Calc
//
//  Created by Demian Tejo on 5/20/17.
//  Copyright © 2017 Demian Tejo. All rights reserved.
//

import UIKit

class Visor: UIView {
    
    var historicLabel : UILabel
    var currentLabel : UILabel
    var newCalc = false
    let EMPTY_CURRENT_SYMBOL = "0"
    
    override init(frame: CGRect) {
        let square = (frame.size.height / 7).rounded()
        self.historicLabel = UILabel(frame: CGRect(x: 20, y: square * 1.7, width: frame.size.width - 40, height: square * 2))
        self.historicLabel.textColor = UIColor.lightTextTKColor()
        self.historicLabel.text = ""
        self.historicLabel.textAlignment = .right
        self.historicLabel.font = UIFont.systemFont(ofSize:35 , weight: UIFontWeightLight)
        self.historicLabel.adjustsFontSizeToFitWidth = false
        self.historicLabel.lineBreakMode = .byTruncatingHead
        
        self.currentLabel = UILabel(frame: CGRect(x: 20, y: frame.size.height - square * 3 , width: frame.size.width - 40, height: square * 2.8 ))
        self.currentLabel.textColor = UIColor.ultraLightTextTKColor()
        self.currentLabel.text = EMPTY_CURRENT_SYMBOL
        self.currentLabel.textAlignment = .right
        self.currentLabel.font = UIFont.systemFont(ofSize: 60 , weight: UIFontWeightLight)
        self.currentLabel.adjustsFontSizeToFitWidth = true
        self.currentLabel.minimumScaleFactor = 0.2
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkTKColor()
        self.addSubview(self.historicLabel)
        self.addSubview(self.currentLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateViewsWith(mathExpresion:MathExpresion?, currentInput:String?){
        self.clear()
        if let mathExpresion = mathExpresion {
            self.historicLabel.text = mathExpresion.stringRepresentation
            if mathExpresion.finished {
                self.historicLabel.text?.append(" = ")
                if let doubleResult = mathExpresion.result.toDouble() {
                    if doubleResult > 0.00001 {
                        self.currentLabel.text = mathExpresion.result
                    }else{
                        self.currentLabel.text = "0"
                    }
                }else {
                    self.currentLabel.text = "✕"
                }
            }else{
                self.currentLabel.text = currentInput
            }
        }else{
            if let doubleResult = currentInput?.toDouble() {
                if doubleResult > 0.00001 {
                    self.currentLabel.text = "0"
                }
                self.currentLabel.text = currentInput
            }else{
                self.currentLabel.text = currentInput
            }
        }
    }
    func updateViewsWith2(historicInput:String, currentInput:String){
        self.clear()
        self.historicLabel.text = historicInput
        self.currentLabel.text = currentInput
    }
    
    func clearHistoric(){
        self.historicLabel.text = ""
    }
    
    func clearCurrent(){
        self.currentLabel.text = EMPTY_CURRENT_SYMBOL
    }
    
    func clear(){
        clearHistoric()
        clearCurrent()
    }
}
