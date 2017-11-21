//
//  WeekViewController.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit

protocol WeekViewControllerDelegate {
    func controllerDidRefresh(controller: WeekViewController)
}

class WeekViewController: WeatherViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var delegate: WeekViewControllerDelegate?
    
    var viewModel: WeekViewViewModel? {
        didSet {
            updateView()
        }
    }
    
    fileprivate lazy var dayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func reloadData() {
        updateView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupTableView()
        setupRefreshControl()
    }
    
    private func updateView() {
        activityIndicatorView.stopAnimating()
        tableView.refreshControl?.endRefreshing()
        if let _ = viewModel {
            updateWeatherDataContainer()
        } else {
            messageLabel.isHidden = false
            messageLabel.text = "Weather was unable to fetch the data."
        }
    }
    
    private func setupTableView() {
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    private func setupRefreshControl() {
        // Initialize Refresh Control
        let refreshControl = UIRefreshControl()
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(WeekViewController.didRefresh(sender:)), for: .valueChanged)
        // Update Table View)
        tableView.refreshControl = refreshControl
    }
    
    // MARK: -
    
    private func updateWeatherDataContainer() {
        weatherDataContainer.isHidden = false
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc func didRefresh(sender: UIRefreshControl) {
        delegate?.controllerDidRefresh(controller: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension WeekViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDayTableViewCell.reuseIdentifier, for: indexPath) as? WeatherDayTableViewCell else { fatalError("Unexpected Table View Cell") }
        if let weatherDayRepresntable = viewModel?.viewModel(for: indexPath.row) {
            cell.configure(withViewModel: weatherDayRepresntable)
        }
        return cell
    }
}
