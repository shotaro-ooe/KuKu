//
//  QuestionViewController.swift
//  KuKu
//
//  Created by 大江祥太郎 on 2018/12/26.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import AudioToolbox
import LTMorphingLabel

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var calcLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionNumLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var maruImageView: UIImageView!
    @IBOutlet weak var batsuImageView: UIImageView!
    
     var timer:Timer!
    
    var count:Double = 90.0
    //数字を判別するフラグ
    var modeNum:Int = 0
    
    //秒数を判別するフラグ
    var modeSecond:Int = 0
    
    var leftNumber :Int = 0
    var rightNumber :Int = 0
    
    var answer:Int = 0
    
    var result:Int=0
    
    //問題数
    var questionNum:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch modeSecond {
        case 30:
            count = 30.0
            timerLabel.text = "30.0"
        case 60:
            count = 60.0
            timerLabel.text = "60.0"
        case 90:
            count = 90.0
            timerLabel.text = "90.0"
        default:
            break
        }

        startTimer()
        
    }
    //何桁の問題か判別するための値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResault"{
            let resultVC = segue.destination as! ResaultViewController
            
            resultVC.modeNum = modeNum
            resultVC.modeSecond = modeSecond
        }
    }
    //乱数
    func arc4random(lower: UInt32, upper: UInt32) -> UInt32 {
        guard upper >= lower else {
            return 0
        }
        
        return arc4random_uniform(upper - lower) + lower
    }
    //    問題を出す関数
    func showQuestion(){
        leftNumber = 1
        rightNumber=Int(arc4random(lower: 1, upper: 10))
        leftLabel.text = String(leftNumber)
        rightLabel.text = String(rightNumber)
        calcLabel.text = "×"
    }
    //回答チェック
    func checkQuestion(){
        if result == answer{
            questionNum += 1
            questionNumLabel.text = String(questionNum)
            //正解音
            AudioServicesPlayAlertSound(1025)
            
            //正解アニメーション
            UIView.animate(withDuration: 0.7, animations: {
                self.maruImageView.alpha = 1.0
            }, completion: { finished in
                self.maruImageView.alpha = 0.0
            })
            
            showQuestion()
        }else{
            //不正解音
            AudioServicesPlayAlertSound(1006)
            //audioPlayer.pause()
            
            UIView.animate(withDuration: 0.7, animations: {
                self.batsuImageView.alpha = 1.0
            }, completion: { finished in
                self.batsuImageView.alpha = 0.0
            })
            
            
        }
        answer = 0
        answerLabel.text = "0"
        
    }
        
    
    @IBAction func okButton(_ sender: Any) {
        result = leftNumber * rightNumber
        checkQuestion()
    }
    @IBAction func cButton(_ sender: Any) {
        answer = 0
        answerLabel.text = String(answer)
    }
    @IBAction func zeroButton(_ sender: Any) {
        if answerLabel.text != "0"{
            answer = 10*answer + 0
        }
        answerLabel.text = String(answer)
    }
    @IBAction func oneButton(_ sender: Any) {
        calcProcess(index: 1)
    }
    
    @IBAction func twoButton(_ sender: Any) {
        calcProcess(index: 2)
    }
    @IBAction func threeButton(_ sender: Any) {
        calcProcess(index: 3)
    }
    @IBAction func fourButton(_ sender: Any) {
        calcProcess(index: 4)
    }
    @IBAction func fiveButton(_ sender: Any) {
        calcProcess(index: 5)
    }
    @IBAction func sixButton(_ sender: Any) {
        calcProcess(index: 6)
    }
    @IBAction func sevenButton(_ sender: Any) {
        calcProcess(index: 7)
    }
    @IBAction func eightButton(_ sender: Any) {
        calcProcess(index: 8)
    }
    @IBAction func nineButton(_ sender: Any) {
        calcProcess(index: 9)
    }
    func calcProcess(index:Int){
        if answerLabel.text == "0"{
            answer = index
        }
        if answerLabel.text != "0"  {
            answer = 10*answer + index
        }
        
        answerLabel.text = String(answer)
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(QuestionViewController.update), userInfo: nil, repeats: true)
    }
    
    //    timer
    @objc func update(){
        count = count - 0.1
        timerLabel.text = String(format: "%.1f", count)
        
        if count > 0{
            self.performSegue(withIdentifier: "toResault", sender: nil)
        }
        
    }
    
    
    

}
