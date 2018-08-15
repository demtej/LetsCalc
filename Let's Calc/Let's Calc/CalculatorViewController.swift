//
//  CalculatorViewController.swift
//  iToolkit
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
        self.view.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
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
        self.view.backgroundColor = UIColor.darkGray
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func updateViews(){
        self.visor.updateViewsWith(mathExpresion: self.viewModel.currentMathExpresion, currentInput: self.viewModel.currentInput)
    }
    
    func pressButton(button : CalculatorButton) {
        self.viewModel.doAction(button.actionType, operatorValue: button.operatorValue, digit: button.symbol)
    }
    func getScreenHeight() -> CGFloat {
        return self.view.frame.size.height - PXLayout.getSafeAreaTopInset() - PXLayout.getSafeAreaBottomInset()
    }
}
