//
//  QuizModel.swift
//  QuizUnicampiOS
//
//  Created by Eduardo Pedroso on 10/29/15.
//  Copyright © 2015 Eduardo Pedroso. All rights reserved.
//

import Foundation
import UIKit

class Question{
    var strQuestion : String!
    var imgQuestion : UIImage!
    var answers : [Answer]! // Vetor de objetos da classe Answer para armazenar respostas
    
    init(question : String, strImageFileName : String, answers : [Answer]){
        self.strQuestion = question
        self.imgQuestion = UIImage(named: strImageFileName)
        self.answers = answers
    }
}

class Answer{
    var strAnswer : String!
    var isCorrect : Bool!
    
    init(answer : String, isCorrect : Bool){
        self.strAnswer = answer
        self.isCorrect = isCorrect
    }
}