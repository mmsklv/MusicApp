//
//  MainScreenPresenter.swift
//  MusicApp
//
//  Created by MacBook on 06.07.2022.
//

import Foundation
import UIKit

// MARK: Protocol

protocol MainScreenPresenterProtocol : AnyObject {
    func updateTime(_ days : String, _ hours : String, _ minutes : String, _ seconds : String)
    func presentPopupScreen()
}

class MainScreenPresenter  {
    
    // MARK: Property
    
    weak var delegate : MainScreenPresenterProtocol?
    var seconds: Int = 86400
    var timer : Timer?
    let defaults = UserDefaults.standard
    var firstMovedToForeground = true
    
    // MARK: NotificationCenter

    func addObserver() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        nc.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appMovedToBackground() {
        firstMovedToForeground = false
        print(seconds)
        defaults.set(seconds, forKey: "currentTime")
        timer?.invalidate()
    }
    
    @objc func appMovedToForeground() {
        if !firstMovedToForeground {
        seconds = defaults.integer(forKey: "currentTime")
        timerStarted()
        }
    }
    
    // MARK: Work with timer
           
    func timerStarted() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.seconds -= 1
            self.updateTimerCounter()
            if self.seconds == 0 {
                timer.invalidate()
            }
        }
    }
    
    func hmsFrom(seconds: Int, completion: @escaping (_ days :Int,_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
        completion((seconds / 86400)  ,(seconds % 86400) / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
   
    func updateTimerCounter() {
        hmsFrom(seconds: seconds) { days, hours, minutes, seconds in
            let days = self.getStringFrom(seconds: days)
            let hours = self.getStringFrom(seconds: hours)
            let minutes = self.getStringFrom(seconds: minutes)
            let seconds = self.getStringFrom(seconds: seconds)
            
            print("\(days):\(hours):\(minutes):\(seconds)")
            
            self.delegate?.updateTime(days, hours, minutes, seconds)
            
        }
    }
    
    // MARK: Coordinator

    func activateOfferPresentView() {
        timer?.invalidate()
        self.delegate?.presentPopupScreen()
    }
}
