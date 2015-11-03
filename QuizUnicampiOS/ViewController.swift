//
//  ViewController.swift
//  QuizUnicampiOS
//
//  Created by Eduardo Pedroso on 10/27/15.
//  Copyright © 2015 Eduardo Pedroso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var imgQuestion: UIImageView!
    
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    @IBOutlet weak var btnAnswer4: UIButton!
    
    @IBOutlet weak var viewFeedBack: UIView!
    @IBOutlet weak var lbFeedBack: UILabel!
    @IBOutlet weak var btnFeedBack: UIButton!
    
    var questions : [Question]!
    var currentQuestion = 0
    var grade = 0.0
    var quizEnded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let q0answer0 = Answer(answer: "Homer Torta", isCorrect: true)
        let q0answer1 = Answer(answer: "Capitão Torta", isCorrect: false)
        let q0answer2 = Answer(answer: "o Torteiro", isCorrect: false)
        let q0answer3 = Answer(answer: "Super Homer", isCorrect: false)
        let question0 = Question(question: "Qual o nome do super heroi que homer está vestido?", strImageFileName: "homer", answers: [q0answer0,q0answer1,q0answer2,q0answer3])
        
        let q1answer0 = Answer(answer: "Mãe de Homer", isCorrect: true)
        let q1answer1 = Answer(answer: "Mãe de Marge", isCorrect: false)
        let q1answer2 = Answer(answer: "Esposa do Reverendo", isCorrect: false)
        let q1answer3 = Answer(answer: "Professora da Lisa", isCorrect: false)
        let question1 = Question(question: "Quem é a personagem da foto acima?", strImageFileName: "mona", answers: [q1answer0,q1answer1,q1answer2,q1answer3])
        
        let q2answer0 = Answer(answer: "Sr. Burns, Diretor Skinner, Ned Flanders", isCorrect: true)
        let q2answer1 = Answer(answer: "Sr. Burns, Ned Flanders, Moe", isCorrect: false)
        let q2answer2 = Answer(answer: "Ned Flanders, Diretor Skinner, Sr. Burns", isCorrect: false)
        let q2answer3 = Answer(answer: "Moe, Lenny, Ned Flanders", isCorrect: false)
        let question2 = Question(question: "Quais os nomes dos personagens, respectivamente?", strImageFileName: "ned", answers: [q2answer0,q2answer1,q2answer2,q2answer3])
        
        let q3answer0 = Answer(answer: "Abe Simpson", isCorrect: true)
        let q3answer1 = Answer(answer: "Fred Simpson", isCorrect: false)
        let q3answer2 = Answer(answer: "Homer Simpson Senior", isCorrect: false)
        let q3answer3 = Answer(answer: "Herb Simpson", isCorrect: false)
        let question3 = Question(question: "Qual o nome do personagem acima?", strImageFileName: "abe", answers: [q3answer0,q3answer1,q3answer2,q3answer3])
        
        let q4answer0 = Answer(answer: "Nirvana", isCorrect: true)
        let q4answer1 = Answer(answer: "Alice in Chains", isCorrect: false)
        let q4answer2 = Answer(answer: "Iron Maiden", isCorrect: false)
        let q4answer3 = Answer(answer: "Queen", isCorrect: false)
        let question4 = Question(question: "De qual banda pertence a capa desse CD?", strImageFileName: "bart", answers: [q4answer0,q4answer1,q4answer2,q4answer3])
        
        let q5answer0 = Answer(answer: "Nelson", isCorrect: true)
        let q5answer1 = Answer(answer: "Milhouse", isCorrect: false)
        let q5answer2 = Answer(answer: "Brendon", isCorrect: false)
        let q5answer3 = Answer(answer: "Ralph", isCorrect: false)
        let question5 = Question(question: "Qual é o nome do personagem acima?", strImageFileName: "nelson", answers: [q5answer0,q5answer1,q5answer2,q5answer3])

        
        
        questions = [question0, question1,question2,question3,question4,question5]
        
        startQuiz()
        
    }
    
    func startQuiz(){
        questions.shuffle()
        for(var i=0;i<questions.count;i++){
            questions[i].answers.shuffle()
        }
        
        quizEnded = false
        grade = 0.0
        currentQuestion = 0
        
        showQuestion(0)
    }
    
    func showQuestion(questionId : Int){
        btnAnswer1.enabled = true
        btnAnswer2.enabled = true
        btnAnswer3.enabled = true
        btnAnswer4.enabled = true
        
        lbQuestion.text = questions[questionId].strQuestion
        imgQuestion.image = questions[questionId].imgQuestion
        btnAnswer1.setTitle(questions[questionId].answers[0].strAnswer, forState: UIControlState.Normal)
        btnAnswer2.setTitle(questions[questionId].answers[1].strAnswer, forState: UIControlState.Normal)
        btnAnswer3.setTitle(questions[questionId].answers[2].strAnswer, forState: UIControlState.Normal)
        btnAnswer4.setTitle(questions[questionId].answers[3].strAnswer, forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chooseAnswer1(sender: AnyObject) {
        selectAnswer(0)
    }

    @IBAction func chooseAnswer2(sender: AnyObject) {
        selectAnswer(1)
    }

    @IBAction func chooseAnswer3(sender: AnyObject) {
        selectAnswer(2)
    }
    
    @IBAction func chooseAnswer4(sender: AnyObject) {
        selectAnswer(3)
    }
    
    func selectAnswer(answerid : Int){
        btnAnswer1.enabled = false
        btnAnswer2.enabled = false
        btnAnswer3.enabled = false
        btnAnswer4.enabled = false
        
        viewFeedBack.hidden = false
        
        var answer : Answer = questions[currentQuestion].answers[answerid]
        
        if(answer.isCorrect == true){
            grade = grade + 1.0
            lbFeedBack.text = answer.strAnswer + "\nResposta Correta!"
        }else{
            lbFeedBack.text = answer.strAnswer + "\nResposta errada!"
        }
        
        if(currentQuestion < questions.count - 1){
            btnFeedBack.setTitle("Proxima", forState: UIControlState.Normal)
        }else{
            btnFeedBack.setTitle("Ver Nota", forState: UIControlState.Normal)
        }
        
        
        
    }
    
    @IBAction func btnFeedBackAction(sender: AnyObject) {
        viewFeedBack.hidden = true
        
        if(quizEnded){
            startQuiz()
        }else{
            nextQuestion()
        }
    }
    
    func nextQuestion(){
        currentQuestion++
        
        if(currentQuestion < questions.count){
            showQuestion(currentQuestion)
        }else{
            endQuiz()
        }
    }
    
    func endQuiz(){
        grade = grade / Double(questions.count) * 100.0
        quizEnded = true
        viewFeedBack.hidden = false
        lbFeedBack.text = "Sua Nota : \(grade)"
        btnFeedBack.setTitle("Refazer", forState: UIControlState.Normal)
    }
    
}

