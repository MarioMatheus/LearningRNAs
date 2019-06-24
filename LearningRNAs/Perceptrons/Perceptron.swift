//
//  File.swift
//  LearningRNAs
//
//  Created by Mario Matheus on 17/04/19.
//  Copyright © 2019 Thundra Project. All rights reserved.
//

import Foundation


/// Protocol that define perceptron objects
protocol Perceptron: class {
    
    /// Matrix with dataset used to train RNA
    var dataset: Matrix { get set }
    
    /// Weights matrix to calculate the activation variable
    var weights: Matrix { get set }
    
    /// Use to define RNA learning rate, 0 < l << 1
    var learningRate: Double { get set }
    
    /// Max number of iterations in dataset on weights fit
    var maxEpochIterations: Int { get set }
    
    /// Value of bias input in RNA
    var biasInput: Double { get }
    
    /// Train perceptron fiting your weights with your current database based on learning rate and max epoch iteractions
    func fit()
    
    
    /// Predict a category to a pattern based on current fiting
    ///
    /// - Parameter pattern: pattern with features based on current dataset
    /// - Returns: output - array of activation variables, category - class to pattern passed on parameter
    func predict(with pattern: [Double]) -> (output: [Double], category: Double)
    
}
