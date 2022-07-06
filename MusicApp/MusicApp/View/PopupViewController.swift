//
//  PopupViewController.swift
//  MusicApp
//
//  Created by MacBook on 06.07.2022.
//

import UIKit

class PopupViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var greatLabel: UILabel!
    @IBOutlet weak var activatedTimeLabel: UILabel!
    
    var time : [String] = []
  
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: SetupUI

    fileprivate func setupUI() {
        let stringRepresentation = time.joined(separator:":").replacingOccurrences(of: "00:", with: "", options: .literal, range: nil)
        print(stringRepresentation)
        activatedTimeLabel.text = "Offer activated at \(stringRepresentation)"
        view.backgroundColor = .clear
        popupView.layer.cornerRadius = 12
        greatLabel.layer.shadowColor = UIColor.systemBlue.cgColor
        greatLabel.layer.shadowRadius = 3.0
        greatLabel.layer.shadowOpacity = 1.0
        greatLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        greatLabel.layer.masksToBounds = false
    }
}
