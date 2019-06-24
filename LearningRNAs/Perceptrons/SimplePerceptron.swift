//
//  SimplePerceptron.swift
//  LearningRNAs
//
//  Created by Mario Matheus on 16/04/19.
//  Copyright © 2019 Thundra Project. All rights reserved.
//

import Foundation


class SimplePerceptron: Perceptron {
    
    var dataset: Matrix
    var learningRate: Double
    var maxEpochIterations: Int
    
    let biasInput: Double = -1
    var weights: Matrix
    
    init(withDataset dataset: Matrix, learningRate: Double = 0.1, maxEpochIterations: Int = 1000) {
        self.dataset = dataset
        self.learningRate = learningRate
        self.maxEpochIterations = maxEpochIterations
        self.weights = Matrix.random(rows: 1, columns: dataset.columns)
    }
    
    
    func fit() {
        print("Weights fit process initialized, ...")
        for i in 1...maxEpochIterations {
            var errorCount = 0
            dataset.forEach({ data in
                let (pattern, category) = getPatternAndCategory(from: data)
                let (_, predict) = self.predict(with: pattern)
                if predict != category {
                    errorCount += 1
                    let error = category - predict
                    weights += learningRate * error * Matrix([biasInput] + pattern)
                }
            })
            if errorCount == 0 {
                print("Fit finished with \(i) epoch iteractions")
                return
            }
        }
        print("Maximum number of iterations per epoch exceeded, fit aborted")
    }
    
    func predict(with pattern: [Double]) -> (output: [Double], category: Double) {
        let input = Matrix([biasInput] + pattern)
        let activation = (weights * input).sum()
        return activation >= 0.0 ? ([activation], 1.0) : ([activation], 0.0)
    }
    
    
    private func getPatternAndCategory(from data: ArraySlice<Double>) -> ([Double], Double) {
        var d = data
        let category = d.removeLast()
        return (Array<Double>(d), category)
    }
    
}
