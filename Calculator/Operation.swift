//
//  Operation.swift
//  Calculator
//
//  Created by Dmytro Horodyskyi on 22.01.2023.
//

import Foundation

struct Operation {
    
    var leftValue = ""
    
    var rightValue = ""
    
    var result = ""
    
    var runningNumber = ""
            
    var previousNumber = ""
    
    var dotWasInput = false
    
    var currentOperation: OperatorType = .Nil
    
    var percentNumber = ""
    
    mutating func enterDigit(_ digit: String) {
        if digit == "0" || digit == "000" {
            if runningNumber == "" || runningNumber == "0"{
                runningNumber = "0"
            } else {
                runningNumber += digit
            }
        } else if digit == "." {
            if runningNumber == "" && !dotWasInput {
                runningNumber = "0" + digit
                dotWasInput = true
            } else if !dotWasInput{
                runningNumber += digit
                dotWasInput = true
            }
        } else if runningNumber == "0" && digit != "."{
            runningNumber = digit
        } else {
            runningNumber += digit
        }
    }
    
    mutating func clear() {
        rightValue = ""
        leftValue = ""
        runningNumber = ""
        result = ""
        currentOperation = .Nil
        dotWasInput = false
    }
    
    mutating func operation(_ operation: OperatorType){
        if currentOperation != .Nil && leftValue != ""{
            if runningNumber != "" {
                
                rightValue = runningNumber
                runningNumber = ""
                
                //let left: Decimal =
                
                if currentOperation == .Add {
                    result = "\(Decimal(string: leftValue)! + Decimal(string: rightValue)!)"
                }else if currentOperation == .Subtract {
                    result = "\(Decimal(string: leftValue)! - Decimal(string: rightValue)!)"
                }else if currentOperation == .Multiply {
                    result = "\(Decimal(string: leftValue)! * Decimal(string: rightValue)!)"
                }else if currentOperation == .Divide {
                    result = "\(Decimal(string: leftValue)! / Decimal(string: rightValue)!)"
                }
                leftValue = result
                if (Double(result)?.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double (result) ?? 0))"
                    }
                previousNumber = result
            }
            currentOperation = operation
            dotWasInput = false
        }else {
            leftValue = runningNumber
            previousNumber = runningNumber
            runningNumber = ""
            currentOperation = operation
            dotWasInput = false
        }
    }
    
    mutating func percent() {
        if  previousNumber != "" && runningNumber != "" && runningNumber != "0" {
            enterDigit("%")
            percentNumber = runningNumber
            runningNumber = "\(((Decimal(string: previousNumber) ?? 0) / 100) * (Decimal(string: runningNumber) ?? 0))"
        }
    }
    
    mutating func changeSign() {
        if  runningNumber != "" && runningNumber != "0" {
            if (Double(runningNumber)?.truncatingRemainder(dividingBy: 1) == 0) {
                runningNumber = "\(-(Int(Double (runningNumber) ?? 0)))"
            } else {
                runningNumber = "\(-(Double(runningNumber) ?? 0))"
            }
        }
    }
}
