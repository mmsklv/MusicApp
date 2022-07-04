//
//  ViewController.swift
//  MusicApp
//
//  Created by MacBook on 03.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var secondsCounterLabel: UILabel!
    @IBOutlet weak var minutesCounterLabel: UILabel!
    @IBOutlet weak var hoursCounterLabel: UILabel!
    @IBOutlet weak var daysCounterLabel: UILabel!
    @IBOutlet var activateOfferButton: UIButton!
    @IBOutlet weak var lastMinuteLabel: UILabel!
    @IBOutlet var timerLabelsCollection: [UILabel]!
    
    // MARK: LifeCycle
    
    var seconds: Int = 86400
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for label in timerLabelsCollection {
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 12
        }
        
        hmsFrom(seconds: seconds) { days, hours, minutes, seconds in
            
            let days = self.getStringFrom(seconds: days)
            let hours = self.getStringFrom(seconds: hours)
            let minutes = self.getStringFrom(seconds: minutes)
            let seconds = self.getStringFrom(seconds: seconds)
            
            print("\(days):\(hours):\(minutes):\(seconds)")
        }
        
        activateOfferButton.layer.masksToBounds = true
        activateOfferButton.layer.cornerRadius = 12
        activateOfferButton.applyGradient(colours: [UIColor(named: "Button_gradient_up")!, UIColor(named: "Button_gradient_down")!], locations: [0.0, 1.0])
        timerStarted()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lastMinuteLabel.text = "LAST-MINUTE CHANCE! \nto claim your offer"
    }
    
    func hmsFrom(seconds: Int, completion: @escaping (_ days :Int,_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
        completion((seconds / 86400)  ,(seconds % 86400) / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    // MARK: SetupUI
    
    func timerStarted() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.seconds -= 1
            self.updateTime()
            if self.seconds == 0 {
                timer.invalidate()
            }
        }
    }
    
    
    func updateTime() {
        hmsFrom(seconds: seconds) { days, hours, minutes, seconds in
            
            let days = self.getStringFrom(seconds: days)
            let hours = self.getStringFrom(seconds: hours)
            let minutes = self.getStringFrom(seconds: minutes)
            let seconds = self.getStringFrom(seconds: seconds)
            
            print("\(days):\(hours):\(minutes):\(seconds)")
            
            UIView.transition(with: self.secondsCounterLabel,
                          duration: 0.25,
                           options: .transitionFlipFromRight,
                        animations: { [weak self] in
                self?.secondsCounterLabel.text = seconds
                     }, completion: nil)
            self.daysCounterLabel.text = days
            self.hoursCounterLabel.text = hours
            self.minutesCounterLabel.text = minutes
            self.secondsCounterLabel.text = seconds
        }
    }
    
    
}

