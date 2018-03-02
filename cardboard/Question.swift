//
//  Question.swift
//  cardboard
//
//  Created by Aakash Thumaty on 3/1/18.
//  Copyright © 2018 Aakash Thumaty. All rights reserved.
//

import Foundation

class Question {
    let question: String
    let optionA: String
    let optionB: String
    let optionC: String?
    let optionD: String?
    let A: String?
    let B: String?
    let C: String?
    let D: String?

    init(questionText: String, choiceA: String, choiceB: String, choiceC: String, choiceD: String, Aa: String, Bb: String, Cc: String, Dd: String){
        question = questionText
        optionA = choiceA
        optionB = choiceB
        optionC = choiceC
        optionD = choiceD
        A = Aa
        B = Bb
        C = Cc
        D = Dd
        
    }
}
