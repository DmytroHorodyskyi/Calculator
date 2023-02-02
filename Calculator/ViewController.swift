//
//  ViewController.swift
//  Calculator
//
//  Created by Dmytro Horodyskyi on 07.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var auxiliaryLabel: UILabel!
    
    var model = Operation()
    
    var equalsWasDisplayed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = "0"
        auxiliaryLabel.text = ""
    }
    
    
    
    func setLabelsForOperators(_ operation: OperatorType) {
        if model.previousNumber != "" {
            mainLabel.text = operation.rawValue
            if model.previousNumber.last == "." {
                model.previousNumber.removeLast()
            }
            auxiliaryLabel.text = model.previousNumber + operation.rawValue
            equalsWasDisplayed = false
        }
    }
    
    @IBAction func enterDigitTap(_ sender: UIButton) {
        if equalsWasDisplayed {
            model.clear()
            mainLabel.text = "0"
            auxiliaryLabel.text = ""
            equalsWasDisplayed = false
        }
        if sender.tag == 10{
            model.enterDigit("000")
            mainLabel.text = model.runningNumber
        } else {
            model.enterDigit("\(sender.tag)")
            mainLabel.text = model.runningNumber
        }
    }
    
    @IBAction func dotTap(_ sender: UIButton) {
        model.enterDigit(".")
        mainLabel.text = model.runningNumber
    }
    
    @IBAction func clearTap(_ sender: UIButton) {
        model.clear()
        mainLabel.text = "0"
        auxiliaryLabel.text = ""
        equalsWasDisplayed = false
    }
    
    @IBAction func plusminusTap(_ sender: UIButton) {
        model.changeSign()
    }
    
    @IBAction func percentTap(_ sender: UIButton) {
        model.percent()
        mainLabel.text = model.percentNumber
        equalsWasDisplayed = false
    }
    
    @IBAction func divideTap(_ sender: UIButton) {
        model.operation( .Divide)
        setLabelsForOperators(.Divide)
    }
    
    @IBAction func multiplyTap(_ sender: UIButton) {
        model.operation( .Multiply)
        setLabelsForOperators(.Multiply)
    }
    
    @IBAction func subtractTap(_ sender: UIButton) {
        model.operation( .Subtract)
        setLabelsForOperators(.Subtract)
    }
    
    @IBAction func addTap(_ sender: UIButton) {
        model.operation( .Add)
        setLabelsForOperators(.Add)
    }
    
    @IBAction func equalsTap(_ sender: UIButton) {
        if !equalsWasDisplayed && model.previousNumber != ""{
            model.operation(model.currentOperation)
            auxiliaryLabel.text? += (mainLabel.text ?? "") + "="
            mainLabel.text = model.result
            equalsWasDisplayed = true
        }
    }
}



