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
        self.viewModel = CalculatorViewModel(viewController: CalculatorViewController())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    

    
}
