//
//  ViewController.swift
//  PomidorchikMac
//
//  Created by Serafima on 20.07.2020.
//  Copyright © 2020 Serafima Nerush. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pomodorroButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var breakLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let pomTime = 1500
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    let breakEmojis = ["🛌", "📚", "💫", "🥑", "🍵", "🧘🏽", "🏝", "🛁", "🍰", "🌾", "🦦", "🥦", "🌞", "🥯", "🧆", "🍜", "🥒", "🍐"]
    var buttonPressed = false
    
    
    @IBAction func pomodorroButtonPressed(_ sender: UIButton) {
        if buttonPressed == true {
            timer.invalidate()
            timerLabel.text = "25:00"
            breakLabel.text = ""
            pomodorroButton.setTitle("🍅", for: .normal)
            buttonPressed = false
        } else {
            timer.invalidate()
            totalTime = pomTime
            secondsPassed = 0
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            buttonPressed = true
        }
    }
    
    
    func secondsToMinutesSeconds (seconds : Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime - 300 {
            secondsPassed += 1
            let (m, s) = secondsToMinutesSeconds(seconds: totalTime - secondsPassed)
            if s < 10 {
                timerLabel.text = "\(m):0\(s)"
            } else {
                timerLabel.text = "\(m):\(s)"
            }
        } else if secondsPassed >= totalTime - 300 && secondsPassed < totalTime {
            pomodorroButton.setTitle(breakEmojis.randomElement(), for: .normal)
            secondsPassed += 1
            let (m, s) = secondsToMinutesSeconds(seconds: totalTime - secondsPassed)
            breakLabel.text = "Break!"
            if s < 10 {
                timerLabel.text = "\(m):0\(s)"
            } else {
                timerLabel.text = "\(m):\(s)"
            }
        } else {
            pomodorroButton.setTitle("🍅", for: .normal)
            breakLabel.text = ""
            timerLabel.text = "Well done!"
            timer.invalidate()
            buttonPressed = false
        }
    }
    
}


