//
//  ViewController.swift
//  MusicApp
//
//  Created by MacBook on 03.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet var activateOfferButton: UIButton!
    @IBOutlet weak var lastMinuteLabel: UILabel!
    
    @IBOutlet var timerLabelsCollection: [UILabel]!
    // MARK: LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for label in timerLabelsCollection {
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 12
        }
        activateOfferButton.layer.masksToBounds = true
        activateOfferButton.layer.cornerRadius = 12
        activateOfferButton.applyGradient(colours: [UIColor(named: "Button_gradient_up")!, UIColor(named: "Button_gradient_down")!], locations: [0.0, 1.0])
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lastMinuteLabel.text = "LAST-MINUTE CHANCE! \nto claim your offer"
       
        print(lastMinuteLabel.font)
        print(activateOfferButton.titleLabel?.font)
    }
    
    // MARK: SetupUI
    
    
}

