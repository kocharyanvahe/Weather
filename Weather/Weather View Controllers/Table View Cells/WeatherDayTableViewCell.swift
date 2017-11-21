//
//  WeatherDayTableViewCell.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit

class WeatherDayTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "WeatherDayCell"
    
    // MARK: - Properties
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(withViewModel viewModel: WeatherDayRepresentable) {
        dayLabel.text = viewModel.day
        dateLabel.text = viewModel.date
        iconImageView.image = viewModel.image
        windSpeedLabel.text = viewModel.windSpeed
        temperatureLabel.text = viewModel.temperature
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
