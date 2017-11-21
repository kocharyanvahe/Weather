//
//  DayViewController.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit

protocol DayViewControllerDelegate {
    func controllerDidTapSettingsButton(controller: DayViewController)
}

class DayViewController: WeatherViewController {
    
    // MARK: - Properties
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    // MARK: -
    
    var delegate: DayViewControllerDelegate?
    
    // MARK: -
    
    var viewModel: DayViewViewModel? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reloadData() {
        updateView()
    }
    
    // MARK: - View Methods
    
    private func updateView() {
        activityIndicatorView.stopAnimating()
        if let viewModel = viewModel {
            updateWeatherDataContainer(withViewModel: viewModel)
        } else {
            messageLabel.isHidden = false
            messageLabel.text = "Cloudy was unable to fetch weather data."
        }
    }
    
    private func updateWeatherDataContainer(withViewModel viewModel: DayViewViewModel) {
        weatherDataContainer.isHidden = false
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        descriptionLabel.text = viewModel.summary
        temperatureLabel.text = viewModel.temperature
        windSpeedLabel.text = viewModel.windSpeed
        iconImageView.image = viewModel.image
    }
    
    // MARK: - Actions
    
    @IBAction func didTapSettingsButton(sender: UIButton) {
        delegate?.controllerDidTapSettingsButton(controller: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
