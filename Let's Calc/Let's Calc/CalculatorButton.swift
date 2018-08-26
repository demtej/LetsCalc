//
//  CalculatorButton.swift
//  Let's Calc
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
        if especifications.0 == "." {
            self.symbol = Locale.current.decimalSeparator!
        }else {
            self.symbol = especifications.0
        }
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
        self.label.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightMedium)
        if actionType == .NUMBER {
            self.label.textColor = UIColor.ultraLightTextTKColor()
        }else{
            self.label.textColor = UIColor.lightTextTKColor()
        }

        self.label.textAlignment = .center
        self.addTarget(self, action: #selector(touch), for: .touchDown)
        self.addTarget(self, action: #selector(up), for: .touchDragOutside)
        self.addTarget(self, action: #selector(up), for: .touchUpInside)
        self.addSubview(label)
        let border = CALayer()
        border.backgroundColor = UIColor.lightBorderTKColor().cgColor
        border.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: self.frame.size.width, height:1)
        self.layer.addSublayer(border)
        
    }
    
    func touch() {
            self.backgroundColor = UIColor.darkTKColor()
            self.label.textColor = UIColor.lightTextTKColor()
    }
    func up() {
        self.backgroundColor = self.color
        if actionType == .NUMBER {
            self.label.textColor = UIColor.ultraLightTextTKColor()
        }else{
            self.label.textColor = UIColor.lightTextTKColor()
        }
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

