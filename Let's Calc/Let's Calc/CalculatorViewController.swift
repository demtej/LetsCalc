//
//  CalculatorViewController.swift
//  iToolkit
//
//  Created by Demian Tejo on 5/17/17.
//  Copyright © 2017 Demian Tejo. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController  {

    var viewModel : CalculatorViewModel!
    var keyboard : CalculatorKeyboard!
    var visor : Visor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CalculatorViewModel(viewController : self)
        let hExp = self.view.frame.size.height * 5 / 7
        let yOrigin = self.view.frame.size.height - hExp
        let keyboardFrame = CGRect(x: 0, y: yOrigin.rounded(), width: self.view.frame.size.width, height: hExp.rounded())
        let visorFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: yOrigin.rounded())
        self.keyboard = CalculatorKeyboard(frame: keyboardFrame)
        self.visor = Visor(frame: visorFrame)
        self.keyboard.delegate = self.viewModel
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
}
