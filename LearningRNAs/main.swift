//
//  main.swift
//  LearningRNAs
//
//  Created by Mario Matheus on 16/04/19.
//  Copyright © 2019 Thundra Project. All rights reserved.
//

import Foundation

// IRIS FLOWERS WITH ONELAYERPERCEPTRON /////////////////////////////////////////////////////
let irisDataset = Matrix(irisFlowersDataset)
let olp = OneLayerPerceptron(with: irisDataset)

let accuracy = PerceptronTester.getAccuracy(to: olp, numberOfRealizations: 20, trainDatasetPercetange: 0.8)
print("Acurácia é de aproxidamente \((accuracy*100).rounded())%")


// AND LOGIC ////////////////////////////////////////////////////////////////////////////////
//let ANDDataset = Matrix([
//    [0,0,0],
//    [0,1,0],
//    [1,0,0],
//    [1,1,1]
//    ])
//let simplePerceptron = SimplePerceptron(withDataset: ANDDataset)
//let olPerceptron = OneLayerPerceptron(with: ANDDataset)
//
//simplePerceptron.fit()
//print("SIMPLE PERCEPTRON PREDICTIONS")
//print("0 0 ->", simplePerceptron.predict(with: [0,0]).category)
//print("0 1 ->", simplePerceptron.predict(with: [0,1]).category)
//print("1 0 ->", simplePerceptron.predict(with: [1,0]).category)
//print("1 1 ->", simplePerceptron.predict(with: [1,1]).category)
//
//
//olPerceptron.fit()
//print("ONE LAYER PERCEPTRON PREDICTIONS")
//print("0 0 ->", olPerceptron.predict(with: [0,0]).category)
//print("0 1 ->", olPerceptron.predict(with: [0,1]).category)
//print("1 0 ->", olPerceptron.predict(with: [1,0]).category)
//print("1 1 ->", olPerceptron.predict(with: [1,1]).category)
