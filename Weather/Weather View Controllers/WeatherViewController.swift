//
//  WeatherViewController.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var weatherDataContainer: UIView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        // Configure Message Label
        messageLabel.isHidden = true
        // Configure Weather Data Container
        weatherDataContainer.isHidden = true
        // Configure Activity Indicator View
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }
    
    func imageForIcon(withName name: String) -> UIImage? {
        switch name {
        case "clear-day":
            return UIImage(named: "clear-day")
        case "clear-night":
            return UIImage(named: "clear-night")
        case "rain":
            return UIImage(named: "rain")
        case "snow":
            return UIImage(named: "snow")
        case "sleet":
            return UIImage(named: "sleet")
        case "wind", "cloudy", "partly-cloudy-day", "partly-cloudy-night":
            return UIImage(named: "cloudy")
        default:
            return UIImage(named: "clear-day")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
