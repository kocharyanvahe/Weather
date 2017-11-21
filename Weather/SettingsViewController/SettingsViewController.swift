//
//  SettingsViewController.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func controllerDidChangeTimeNotation(controller: SettingsViewController)
    func controllerDidChangeUnitsNotation(controller: SettingsViewController)
    func controllerDidChangeTemperatureNotation(controller: SettingsViewController)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupTableView()
    }
    
    private func updateView() {
        
    }
    
    // MARK: -
    
    private func setupTableView() {
        tableView.separatorInset = .zero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    private enum Section: Int {
        case time
        case units
        case temperature
        
        var numberOfRows: Int {
            return 2
        }
        
        static var count: Int {
            return (Section.temperature.rawValue + 1)
        }
    }
    
    // MARK: - Table View Data Source Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { fatalError("Unexpected Section") }
        return section.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Unexpected Section") }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as? SettingsTableViewCell else { fatalError("Unexpected Table View Cell") }
        var viewModel: SettingsRepresentable?
        switch section {
        case .time:
            guard let timeNotation = TimeNotation(rawValue: indexPath.row) else {
                fatalError("Unexpected Index Path")
            }
            viewModel = SettingsViewTimeViewModel(timeNotation: timeNotation)
        case .units:
            guard let unitsNotation = UnitsNotation(rawValue: indexPath.row) else {
                fatalError("Unexpected Index Path")
            }
            viewModel = SettingsViewUnitsViewModel(unitsNotation: unitsNotation)
        case .temperature:
            guard let temperatureNotation = TemperatureNotation(rawValue: indexPath.row) else {
                fatalError("Unexpected Index Path")
            }
            viewModel = SettingViewTemperatureViewModel(temperatureNotation: temperatureNotation)
        }
        if let viewModel = viewModel {
            cell.configure(withViewModel: viewModel)
        }
        return cell
    }
    
    // MARK: - Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Unexpected Section") }
        switch section {
        case .time:
            let timeNotation = UserDefaults.timeNotation()
            guard indexPath.row != timeNotation.rawValue else { return }
            if let newTimeNotation = TimeNotation(rawValue: indexPath.row) {
                // Update User Defaults
                UserDefaults.setTimeNotation(timeNotation: newTimeNotation)
                // Notify Delegate
                delegate?.controllerDidChangeTimeNotation(controller: self)
            }
        case .units:
            let unitsNotation = UserDefaults.unitsNotation()
            guard indexPath.row != unitsNotation.rawValue else { return }
            if let newUnitsNotation = UnitsNotation(rawValue: indexPath.row) {
                // Update User Defaults
                UserDefaults.setUnitsNotation(unitsNotation: newUnitsNotation)
                // Notify Delegate
                delegate?.controllerDidChangeUnitsNotation(controller: self)
            }
        case .temperature:
            let temperatureNotation = UserDefaults.temperatureNotation()
            guard indexPath.row != temperatureNotation.rawValue else { return }
            if let newTemperatureNotation = TemperatureNotation(rawValue: indexPath.row) {
                // Update User Defaults
                UserDefaults.setTemperatureNotation(temperatureNotation: newTemperatureNotation)
                // Notify Delegate
                delegate?.controllerDidChangeTemperatureNotation(controller: self)
            }
        }
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
    }
}
