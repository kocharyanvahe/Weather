//
//  SettingsTableViewCell.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - Type Properties
    
    static let reuseIdentifier = "SettingsCell"

    @IBOutlet weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configure Cell
        selectionStyle = .none
    }
    
    func configure(withViewModel viewModel: SettingsRepresentable) {
        mainLabel.text = viewModel.text
        accessoryType = viewModel.accessoryType
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
