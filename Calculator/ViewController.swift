//
//  ViewController.swift
//  Calculator
//
//  Created by Svitlana Dzyuban on 22/5/16.
//  Copyright © 2016 Lana Dzyuban. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var inTheMiddleOfTyping = false
    var pointPresent = false
    
    @IBOutlet private weak var display: UILabel!

    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var calculator = CalculatorModel()
    
    var savedOperation: CalculatorModel.PropertyList?
    
    @IBAction func saveToMemory() {
        savedOperation = calculator.program
    }
    
    @IBAction func readFromMemory() {
        if savedOperation != nil {
            calculator.program = savedOperation!
            displayValue = calculator.result
        }
    }
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if inTheMiddleOfTyping {
            let currentText = display.text!
            if digit == "." {
                if display.text?.characters.indexOf(".") == nil {
                    display.text = currentText + digit
                }
            } else {
                display.text = currentText + digit
            }
        } else {
            display.text = digit
        }
        inTheMiddleOfTyping = true
    }

    @IBAction private func performOperation(sender: UIButton) {
        if inTheMiddleOfTyping {
            calculator.setOperand(displayValue)
            inTheMiddleOfTyping = false
        }
        
        if let operation = sender.currentTitle {
           calculator.performOperation(operation)
        }
        displayValue = calculator.result
    }

}

