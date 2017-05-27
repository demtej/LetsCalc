//
//  CalculatorKeyboard.swift
//  iToolkit
//
//  Created by Demian Tejo on 5/17/17.
//  Copyright © 2017 Demian Tejo. All rights reserved.
//

import UIKit

protocol CalculatorKeyboardListener {
    func pressButton(button : CalculatorButton)
}

class CalculatorKeyboard: UIView {

    var delegate : CalculatorKeyboardListener?
    var elementHeight : CGFloat!
    var elementWidth : CGFloat!
    let calculatorKeys : [(String,Action)] = [("AC",Action.CLEAR),("±",Action.NEGATIVE_POSITIVE),("%",Action.PERCENT),("÷",Action.INTO),("7",Action.NUMBER),("8",Action.NUMBER),("9",Action.NUMBER),("x",Action.TIMES),("4",Action.NUMBER),("5",Action.NUMBER),("6",Action.NUMBER),("-",Action.MINUS),("1",Action.NUMBER),("2",Action.NUMBER),("3",Action.NUMBER),("+",Action.PLUS),("0",Action.NUMBER),("←",Action.DELETE),(".",Action.DOT),("=",Action.EQUALS)]
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.elementHeight = self.frame.size.height / 5
        self.elementWidth = self.frame.size.width / 4
        self.addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        var y : CGFloat = 0
        var elementNumber = 0
        while y < self.frame.size.height {
            var i : CGFloat = 0.0
            while i < 4 {
                let button = CalculatorButton(frame: CGRect(x: elementWidth * i, y: y, width: elementWidth, height: elementHeight), especifications:calculatorKeys[elementNumber], color: UIColor.fromHex("3D385B"))
                button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
                elementNumber = elementNumber + 1
                self.addSubview(button)
                i = i + 1
            }
            y = y + elementHeight
        }
        
    }
  
    func buttonClicked(sender: CalculatorButton) {
        switch sender.actionType {
        case .NUMBER:
            print(sender.symbol)
        default:
            print(sender.actionType)
        }
        if let delegate = delegate {
            delegate.pressButton(button: sender)
        }
    }
}
