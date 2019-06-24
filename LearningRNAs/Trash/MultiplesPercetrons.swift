//
//  MultiplesPercetrons.swift
//  LearningRNAs
//
//  Created by Mario Matheus on 16/04/19.
//  Copyright © 2019 Thundra Project. All rights reserved.
//

import Foundation


class MultiplePerceptron {
    
    var dataset: Matrix {
        didSet {
            self.perceptrons = []
            self.createPerceptrons(self.numberOfPerceptrons)
        }
    }
    
    private var learningRate: Double
    private var maxEpochIterations: Int
    
    var numberOfPerceptrons: Int
    var x0: Double = -1
    var weights: Matrix
    var perceptrons: [SimplePerceptron] = []
    
    init(withDataset dataset: Matrix, numberOfPerceptrons: Int, learningRate: Double = 0.1, maxEpochIterations: Int = 1000) {
        self.dataset = dataset
        self.learningRate = learningRate
        self.maxEpochIterations = maxEpochIterations
        self.numberOfPerceptrons = numberOfPerceptrons
        self.weights = Matrix.random(rows: numberOfPerceptrons, columns: dataset.columns)
        self.createPerceptrons(numberOfPerceptrons)
    }
    
    
    private func createPerceptrons(_ numberOfPerceptrons: Int) {
        for i in 0..<numberOfPerceptrons {
            let perceptronDataset = Matrix(self.dataset.map { row -> [Double] in
                var pattern = [Double](row)
                pattern[pattern.count - 1] = pattern[pattern.count - 1] == Double(i) ? 1.0 : 0.0
                return pattern + []
            })
            let perceptron = SimplePerceptron(withDataset: perceptronDataset,
                                              learningRate: learningRate,
                                              maxEpochIterations: maxEpochIterations)
            perceptrons.append(perceptron)
        }
    }
    
    
    func fit() {
        perceptrons.forEach({ $0.fit() })
    }
    
    
    func predict(withPattern pattern: [Double]) -> Double {
        var results: [([Double], Double)] = []
        perceptrons.forEach({ results.append($0.predict(with: pattern)) })
        var assertCount = 0
        var perceptronIndex = 0
        var greaterActivation = -Double.greatestFiniteMagnitude
        var i = 0
        while i < results.count {
            if results[i].0[0] == 1 {
                assertCount += 1
                if assertCount > 0 && results[i].1 > greaterActivation {
                    greaterActivation = results[i].1
                    perceptronIndex = i
                }
            }
            i += 1
            // para este problema especifico
            if i == results.count && assertCount == 0 {
                perceptronIndex = results[1].1 > results[2].1 ? 1 : 2
            }
        }
        return Double(perceptronIndex)
    }
    
}
