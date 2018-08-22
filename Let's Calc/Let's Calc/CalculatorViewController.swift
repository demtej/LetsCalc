//
//  CalculatorViewController.swift
//
//  Created by Demian Tejo on 5/17/17.
//  Copyright © 2017 Demian Tejo. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, CalculatorKeyboardListener {

    var viewModel : CalculatorViewModel!
    var keyboard : CalculatorKeyboard!
    var visor : Visor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CalculatorViewModel(viewController : self)
        self.view.backgroundColor = UIColor.darkTKColor()
        self.view.layoutIfNeeded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let hExp = getScreenHeight() * 5 / 7
        let yOrigin = getScreenHeight() - hExp + PXLayout.getSafeAreaTopInset()
        let keyboardFrame = CGRect(x: 0, y: yOrigin.rounded(), width: self.view.frame.size.width, height: hExp.rounded())
        let visorFrame = CGRect(x: 0, y: PXLayout.getSafeAreaTopInset(), width: self.view.frame.size.width, height: getScreenHeight() - hExp)
        self.keyboard = CalculatorKeyboard(frame: keyboardFrame)
        self.visor = Visor(frame: visorFrame)
        self.keyboard.delegate = self
        self.view.addSubview(self.keyboard)
        self.view.addSubview(self.visor)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func updateViews(){
        var historicInput = ""
        if let mathExpresion = self.viewModel.currentMathExpresion {
            historicInput = mathExpresion.stringRepresentation
            if mathExpresion.finished {
                historicInput.append(" = ")
                if let doubleResult = mathExpresion.result.toDouble() {
                    if abs(doubleResult) > 0.00001 {
                        self.viewModel.currentInput = mathExpresion.result
                    }else{
                        self.viewModel.currentInput = "0"
                    }
                }else {
                    self.viewModel.currentInput = "✕"
                }
            }else{
                if let doubleResult = self.viewModel.currentInput.toDouble() {
                    if abs(doubleResult) > 0.00001 {
                    }else{
                        self.viewModel.currentInput = "0"
                    }
                }
            }
        }else{
            if let doubleResult = self.viewModel.currentInput.toDouble() {
                if abs(doubleResult) > 0.00001 {
                }else{
                    self.viewModel.currentInput = "0"
                }
            }else{
            }
        }
        self.visor.updateViewsWith(historicInput: historicInput, currentInput: self.viewModel.currentInput)
    }

    func pressButton(button : CalculatorButton) {
        self.viewModel.doAction(button.actionType, operatorValue: button.operatorValue, digit: button.symbol)
    }
    func getScreenHeight() -> CGFloat {
        return self.view.frame.size.height - PXLayout.getSafeAreaTopInset() - PXLayout.getSafeAreaBottomInset()
    }
}
