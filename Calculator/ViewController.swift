//
//  ViewController.swift
//  Calculator
//
//  Created by Dmytro Horodyskyi on 07.01.2023.
//

import UIKit

enum Operations:String {
    case Add = "+"
    case Subtract = "-"
    case Multiply = "*"
    case Divide = "/"
    case Nil = "nil"
    
}

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var auxiliaryLabel: UILabel!
    
    //---------------------------------------------------------------------------------------
    var previousValue = ""
    
    var currentValue = ""
    
    var result = ""
    
    var runningNumber = ""
    
    var currentOperation:Operations = .Nil
    //---------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = "0"
        auxiliaryLabel.text = ""
    }
    //---------------------------------------------------------------------------------------
    func operation(_ operation:Operations){
        if currentOperation != .Nil && previousValue != ""{
            if runningNumber != "" {
                auxiliaryLabel.text! += runningNumber
                currentValue = runningNumber
                runningNumber = ""
                        
                if currentOperation == .Add {
                    result = "\(Double(previousValue)! + Double (currentValue)!)"
                }else if currentOperation == .Subtract {
                    result = "\(Double(previousValue)! - Double(currentValue)!)"
                }else if currentOperation == .Multiply {
                    result = "\(Double(previousValue)! * Double (currentValue)!)"
                }else if currentOperation == .Divide {
                    result = "\(Double (previousValue)! / Double (currentValue)!)"
                }
                previousValue = result
                if (Double (result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double (result)!))"
                    }
                mainLabel.text = result
            }
            currentOperation = operation
        }else {
            auxiliaryLabel.text! += runningNumber
            previousValue = runningNumber
            runningNumber = ""
            currentOperation = operation
            mainLabel.text = operation.rawValue
            auxiliaryLabel.text! += operation.rawValue
            
        }
    }
    //---------------------------------------------------------------------------------------
    
    @IBAction func enterDigitTap(_ sender: UIButton) {
        if sender.tag == 10{
            runningNumber += "000"
            mainLabel.text = runningNumber
            //auxiliaryLabel.text! += "000"
        } else {
            runningNumber += "\(sender.tag)"
            mainLabel.text = runningNumber
            //auxiliaryLabel.text! += "\(sender.tag)"
        }
    }
    
    @IBAction func dotTap(_ sender: UIButton) {
        runningNumber += "."
        mainLabel.text! += runningNumber
    }
    
    @IBAction func clearTap(_ sender: UIButton) {
        currentValue = ""
        previousValue = ""
        runningNumber = ""
        result = ""
        currentOperation = .Nil
        mainLabel.text = "0"
        auxiliaryLabel.text = ""
    }
    
    @IBAction func plusminusTap(_ sender: UIButton) {
        //auxiliaryLabel.text! -= runningNumber
        runningNumber = String(Double(runningNumber)! - 2 * Double(runningNumber)!)
        
    }
    
    @IBAction func percentTap(_ sender: UIButton) {
        runningNumber = String(Double(previousValue)! / 100 * Double(runningNumber)!)
        auxiliaryLabel.text! += "%"
    }
    
    @IBAction func divideTap(_ sender: UIButton) {
        operation( .Divide)
        //auxiliaryLabel.text! += "/"
    }
    
    @IBAction func multiplyTap(_ sender: UIButton) {
        operation( .Multiply)
        //auxiliaryLabel.text! += "*"
    }
    
    @IBAction func subtractTap(_ sender: UIButton) {
        operation( .Subtract)
        //auxiliaryLabel.text! += "-"
    }
    
    @IBAction func addTap(_ sender: UIButton) {
        operation( .Add)
        //auxiliaryLabel.text! += "+"
    }
    
    @IBAction func equalsTap(_ sender: UIButton) {
        operation(currentOperation)
        auxiliaryLabel.text! += "="
    }
}



