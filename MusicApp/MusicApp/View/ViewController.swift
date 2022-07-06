//
//  ViewController.swift
//  MusicApp
//
//  Created by MacBook on 03.07.2022.
//

import UIKit

enum Animation {
    case days
    case hours
    case minutes
    case seconds
}

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var blackoutEffectView: UIView!
    @IBOutlet weak var secondsCounterLabel: UILabel!
    @IBOutlet weak var minutesCounterLabel: UILabel!
    @IBOutlet weak var hoursCounterLabel: UILabel!
    @IBOutlet weak var daysCounterLabel: UILabel!
    @IBOutlet var activateOfferButton: UIButton!
    @IBOutlet weak var lastMinuteLabel: UILabel!
    @IBOutlet var timerLabelsCollection: [UILabel]!
    
    // MARK: Presenter
    
    lazy var presenter = MainScreenPresenter()
    var counter : Int = 0
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.timerStarted()
        presenter.addObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
    
    // MARK: SetupUI
    
    func setupUI() {
        for label in timerLabelsCollection {
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 12
        }
        lastMinuteLabel.text = "LAST-MINUTE CHANCE! \nto claim your offer"
        activateOfferButton.layer.masksToBounds = true
        activateOfferButton.layer.cornerRadius = 12
        _ = activateOfferButton.applyGradient(colours: [UIColor(named: "Button_gradient_up")!, UIColor(named: "Button_gradient_down")!], locations: [0.0, 1.0])
    }
    
    // MARK: Action
    
    @IBAction func ActivateOfferButton(_ sender: UIButton) {
        presenter.activateOfferPresentView()
    }
    
    // MARK: Animation methods

    func updateTimer(counter : Animation) {
        let currentCounter: Animation = counter
        
        switch currentCounter {
        case .seconds:
            animationLabels(labels: [secondsCounterLabel])
        case .days:
            animationLabels(labels: [secondsCounterLabel,minutesCounterLabel,hoursCounterLabel,daysCounterLabel])
        case .hours:
            animationLabels(labels: [secondsCounterLabel,minutesCounterLabel,hoursCounterLabel])
        case .minutes:
            animationLabels(labels: [secondsCounterLabel,minutesCounterLabel])
        }
    }
    
    func animationLabels(labels : [UILabel]) {
        for label in labels {
            UIView.transition(with: label,
                              duration: 0.25,
                              options: .transitionFlipFromRight,
                              animations: { label.text = label.text},
                              completion: nil)
        }
        
        
    }
}

// MARK: Extension

extension ViewController : MainScreenPresenterProtocol {
    
    func updateTime(_ days : String, _ hours : String, _ minutes : String, _ seconds : String) {
        self.daysCounterLabel.text = days
        self.hoursCounterLabel.text = hours
        self.minutesCounterLabel.text = minutes
        self.secondsCounterLabel.text = seconds
        
        //      sorry for if/else D:
        
        if counter == 0 {
            self.updateTimer(counter: .days)
        } else if counter % 60 == 0 {
            self.updateTimer(counter: .minutes)
        } else if counter % 3600 == 0 {
            self.updateTimer(counter: .hours)
        } else {
            self.updateTimer(counter: .seconds)
        }
        counter += 1
    }
    
    func presentPopupScreen() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        vc.modalPresentationStyle = .overCurrentContext
        for label in timerLabelsCollection {
            vc.time.append(label.text ?? "")
        }
        blackoutEffectView.isHidden = false
        blackoutEffectView.alpha = 0.67
        self.present(vc, animated: true, completion: nil)
    }
    
}






