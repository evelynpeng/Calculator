//
//  ViewController.swift
//  Calculator
//
//  Created by Caterina Peng on 2015/2/19.
//  Copyright (c) 2015年 Evelyn Peng. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var userUseddecimal: Bool = false
    
    var brain = CalculatorBrain()

    @IBAction func appenDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            if digit == "." && userUseddecimal == true {
                return
            } else if digit == "." && userUseddecimal == false {
                userUseddecimal = true
            }
            display.text = display.text! + digit
        } else {
            userIsInTheMiddleOfTypingANumber = true
            
            if digit == "." {
                userUseddecimal = true
                display.text = "0."
            } else {
                display.text = digit
            }
        }
    }
    

    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            }else{
                displayValue = 0
            }
        }
    }

    
    @IBAction func clear(sender: UIButton) {
        display.text = "0"
        userIsInTheMiddleOfTypingANumber = false
        userUseddecimal = false
        history.text = "0"
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
//           return nil (need to make display as optional)
        }
        
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
            
            history.text = brain.historyDisplay()
            
//            history.text = ""
//            for element in historyStack {
//                history.text = history.text! + "\(element), "
//            }
        }
    
    }
}

