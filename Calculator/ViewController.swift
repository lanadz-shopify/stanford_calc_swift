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
    
    @IBOutlet weak var display: UILabel!

    
    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if inTheMiddleOfTyping {
            let currentText = display.text!
            display.text = currentText + digit
        } else {
            display.text = digit
        }
        inTheMiddleOfTyping = true
    }

    @IBAction func performOperation(sender: UIButton) {
        inTheMiddleOfTyping = false
        
        if let operation = sender.currentTitle {
            if operation == "П" {
                display.text = String(M_PI)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

