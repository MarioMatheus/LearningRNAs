//
//  OneLayerPerceptron.swift
//  LearningRNAs
//
//  Created by Mario Matheus on 17/04/19.
//  Copyright © 2019 Thundra Project. All rights reserved.
//

import Foundation


class OneLayerPerceptron: Perceptron {
    
    var dataset: Matrix
    var weights = Matrix()
    
    var categoriesMap: [Double: [Double]] = [:]
    
    var maxEpochIterations: Int
    var learningRate: Double
    
    let biasInput: Double = -1
    
    
    init(with dataset: Matrix, learningRate: Double = 0.1, maxEpochIterations: Int = 300) {
        self.dataset = dataset
        self.learningRate = learningRate
        self.maxEpochIterations = maxEpochIterations
        self.setupCategories()
        self.weights = Matrix.random(rows: self.categoriesMap.keys.count, columns: self.dataset.columns)
    }
    
    
    func fit() {
        print("Weights fit process initialized, ...")
        for i in 1...maxEpochIterations {
            var errorCount = 0
            dataset.forEach { data in
                let (pattern, category) = getPatternAndCategory(from: data)
                let (predict, _) = self.predict(with: pattern)
                if predict.elementsEqual(categoriesMap[category]!) == false {
                    errorCount += 1
                    let error = Matrix(categoriesMap[category]!) - Matrix(predict)
                    let input = Array<[Double]>(repeating: [biasInput] + pattern, count: self.categoriesMap.keys.count)
                    var errorInput: [[Double]] = []
                    for i in 0..<error.count {
                        errorInput.append( (error[i] * Matrix(input) ).array[0] )
                    }
                    self.weights += learningRate * Matrix(errorInput)
                }
            }
            if errorCount == 0 {
                print("Fit finished with \(i) epoch iteractions")
                return
            }
        }
        print("Maximum number of iterations per epoch exceeded, fit aborted")
    }
    
    
    func predict(with pattern: [Double]) -> (output: [Double], category: Double) {
        let input = Matrix([biasInput] + pattern)
        var activations = (self.weights * input).sumRows().map({ Array<Double>($0)[0] })
        let outputs = activations.map({ $0 >= 0.0 ? 1.0 : 0.0 })
        var outputForLabel = outputs
        
        let oneCount = outputs.filter({ $0 == 1.0 }).count
        for i in 0..<outputForLabel.count {
            if oneCount > 1 && activations[i] != activations.max() {
                outputForLabel[i] = 0.0
            } else if oneCount == 0 && activations[i] == activations.min() {
                outputForLabel[i] = 1.0
            }
        }
        
        var mapKey = -1.0
        categoriesMap.forEach { (key, value) in
            if value.elementsEqual(outputForLabel) {
                mapKey = key
            }
        }
        
        return (outputs, mapKey)
    }
    
    
    private func setupCategories() {
        var categories: [Double] = []
        
        self.dataset.forEach { pattern in
            if let category = pattern.last, !categories.contains(category) {
                categories.append(category)
            }
        }
        
        var i = 0
        while i < categories.count {
            var map = Array<Double>(repeating: 0.0, count: categories.count)
            map[i] = 1.0
            categoriesMap[categories[i]] = map
            i += 1
        }
        
    }
    
    
    private func getPatternAndCategory(from data: ArraySlice<Double>) -> ([Double], Double) {
        var d = data
        let category = d.removeLast()
        return (Array<Double>(d), category)
    }
}
