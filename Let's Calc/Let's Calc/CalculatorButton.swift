//
//  CalculatorButton.swift
//  iToolkit
//
//  Created by Demian Tejo on 5/19/17.
//  Copyright © 2017 Demian Tejo. All rights reserved.
//

import UIKit

class CalculatorButton: UIButton {

    let MARGIN_RATE : CGFloat = 0.05
    let symbol : String
    let actionType : Action
    let color : UIColor
    let label : UILabel
    var operatorValue : Operator? {
        get {
            switch actionType {
            case .PLUS:
                return Operator.PLUS
            case .TIMES:
                return Operator.TIMES
            case .MINUS:
                return Operator.MINUS
            case .INTO:
                return Operator.INTO
            default:
                return nil
            }
        }
    }
    
    init(frame: CGRect, especifications:(String,Action), color : UIColor) {
        self.symbol = especifications.0
        self.actionType = especifications.1
        self.color = color
        let marginX = frame.width * MARGIN_RATE
        let marginY = frame.height * MARGIN_RATE
        let frameLabel = CGRect(x: marginX, y: marginY, width: frame.size.width - (2 * marginX), height: frame.size.height - (2 * marginY))
        self.label = UILabel(frame: frameLabel)
        super.init(frame: frame)
        self.makeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView(){
        self.backgroundColor = self.color
        self.label.text = self.symbol
        self.label.font = UIFont.systemFont(ofSize: self.frame.size.height * 0.45, weight: UIFontWeightThin)
        self.label.textColor = UIColor.darkTextTKColor()
        self.label.textAlignment = .center
        self.addTarget(self, action: #selector(touch), for: .touchDown)
        self.addTarget(self, action: #selector(up), for: .touchDragOutside)
        self.addTarget(self, action: #selector(up), for: .touchUpInside)
        self.addSubview(label)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightBorderTKColor().cgColor
        
    }
    
    func touch() {
            self.backgroundColor = self.color.darker()
            self.label.textColor = UIColor.lightTextTKColor()
    }
    func up() {
            self.backgroundColor = self.color
        self.label.textColor = UIColor.darkTextTKColor()
    }
}

enum Action {
    case NUMBER
    case CLEAR
    case NEGATIVE_POSITIVE
    case PERCENT
    case INTO
    case TIMES
    case MINUS
    case PLUS
    case EQUALS
    case DOT
    case DELETE
}

