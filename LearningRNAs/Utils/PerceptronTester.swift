//
//  PerceptronTester.swift
//  LearningRNAs
//
//  Created by Mario Matheus on 17/04/19.
//  Copyright © 2019 Thundra Project. All rights reserved.
//

import Foundation

class PerceptronTester {
    
    class func getAccuracy(to perceptron: Perceptron, numberOfRealizations: Int, trainDatasetPercetange: Double) -> Double {
        let defaultDataset = perceptron.dataset
        let defaultWeights = perceptron.weights
        
        var averages: [Double] = []
        
        print("Tests start")
        for _ in 1...numberOfRealizations {
            let (trainDataset, testDataset) = PerceptronTester.splitDatasetToTrain(perceptron.dataset, trainDatasetPercetange)
            var correctsCount = 0
            perceptron.dataset = Matrix(trainDataset)
            perceptron.fit()
            for testPattern in testDataset {
                var pattern = testPattern
                pattern.removeLast()
                if perceptron.predict(with: Array<Double>(pattern)).category == testPattern.last {
                    correctsCount += 1
                }
            }
            averages.append( Double(correctsCount) / Double(testDataset.count) )

            perceptron.dataset = defaultDataset
            perceptron.weights = defaultWeights
        }
        
        print("Tests finished")
        return averages.reduce(0, { $0 + $1 }) / Double(averages.count)
    }
    
    
    class func splitDatasetToTrain(_ dataset: Matrix,_ trainDatasetPercentage: Double) -> (trainDS: [[Double]], testDS: [[Double]]) {
        var testDatasetVector: [[Double]] = dataset.array.shuffled()
        var trainDatasetVector: [[Double]] = []
        
        let numberOfElements = Double(testDatasetVector.count) * trainDatasetPercentage
        for _ in 1...Int(numberOfElements) {
            trainDatasetVector.append(testDatasetVector.remove(at: 0))
        }
        
        return (trainDatasetVector, testDatasetVector)
    }
    
}

