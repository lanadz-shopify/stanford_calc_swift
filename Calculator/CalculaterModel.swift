//
//  CalculaterModel.swift
//  Calculator
//
//  Created by Svitlana Dzyuban on 28/5/16.
//  Copyright © 2016 Lana Dzyuban. All rights reserved.
//

import Foundation

class CalculatorModel {

    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "C" : Operation.ClearInput,
        "√" : Operation.UnaryOperation(sqrt),
        "±" : Operation.UnaryOperation({ -1 * $0 }),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "-" : Operation.BinaryOperation({ $0 - $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "=" : Operation.Equals,
     ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case ClearInput
    }
    
    private var accumulator = 0.0
    
    private var internalProgram = [AnyObject]()
    
    private var pending: PendingBinaryOperation?
    
    private func executeBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryOperation(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private struct PendingBinaryOperation {
        var binaryOperation: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    typealias PropertyList = AnyObject
   
    var program: PropertyList {
        get {
            return internalProgram
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [PropertyList] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand)
                    } else if let operation = op as? String {
                        performOperation(operation)
                    }
                }
            }
        }
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
        internalProgram.append(operand)
    }
    
    private func clear() {
        pending = nil
        accumulator = 0
        internalProgram.removeAll()
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            internalProgram.append(symbol)
            switch operation {
            case .Constant(let associatedValue):
                accumulator = associatedValue
            case .BinaryOperation(let function):
                executeBinaryOperation()
                pending = PendingBinaryOperation(binaryOperation: function, firstOperand: accumulator)
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .Equals:
                executeBinaryOperation()
            case .ClearInput:
                clear()
            }
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}

