//
//  CalculatorViewModelTest.swift
//  Let's Calc
//
//  Created by Demian Tejo on 5/27/17.
//  Copyright © 2017 Demian Tejo. All rights reserved.
//

import XCTest

class CalculatorViewModelTest: XCTestCase {
    
    var viewModel : CalculatorViewModel!
    
    override func setUp() {
        super.setUp()
        self.viewModel = CalculatorViewModel(viewController: nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMathExpresion() {
       self.viewModel.doAction(Action.NUMBER, operatorValue: nil, digit: "1")
        XCTAssertEqual("1", self.viewModel.currentInput)
        self.viewModel.doAction(Action.NUMBER, operatorValue: nil, digit: "2")
        XCTAssertEqual("12", self.viewModel.currentInput)
        self.viewModel.doAction(Action.NUMBER, operatorValue: nil, digit: "3")
        XCTAssertEqual("123", self.viewModel.currentInput)
        self.viewModel.doAction(Action.NUMBER, operatorValue: nil, digit: "4")
        XCTAssertEqual("1234", self.viewModel.currentInput)
        self.viewModel.doAction(Action.NUMBER, operatorValue: nil, digit: "5")
        XCTAssertEqual("12345", self.viewModel.currentInput)

        
    }
    

    
}
