//
//  ViewController.swift
//  Weather
//
//  Created by Kocharyan, Vahe on 11/20/17.
//  Copyright © 2017 Kocharyan, Vahe. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: - Constants
    
    private let segueDayView = "SegueDayView"
    private let segueWeekView = "SegueWeekView"
    fileprivate let SegueSettingsView = "SegueSettingsView"
    
    // MARK: - Properties
    
    @IBOutlet fileprivate var dayViewController: DayViewController!
    @IBOutlet fileprivate var weekViewController: WeekViewController!
    
    // MARK: -
    
    fileprivate var currentLocation: CLLocation? {
        didSet {
            fetchWeatherData()
        }
    }
    
    fileprivate lazy var dataManager = {
        return DataManager(baseURL: API.AuthenticatedBaseURL)
    }()
    
    private lazy var locationManager: CLLocationManager = {
        // Initialize Location Manager
        let locationManager = CLLocationManager()
        // Configure Location Manager
        locationManager.distanceFilter = 1000.0
        locationManager.desiredAccuracy = 1000.0
        
        return locationManager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationHandling()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case segueDayView:
            if let dayViewController = segue.destination as? DayViewController {
                self.dayViewController = dayViewController
                // Configure Day View Controller
                self.dayViewController.delegate = self
            } else {
                fatalError("Unexpected Destination View Controller")
            }
        case segueWeekView:
            if let weekViewController = segue.destination as? WeekViewController {
                self.weekViewController = weekViewController
                // Configure Day View Controller
                self.weekViewController.delegate = self
            } else {
                fatalError("Unexpected Destination View Controller")
            }
        case SegueSettingsView:
            if let navigationController = segue.destination as? UINavigationController,
                let settingsViewController = navigationController.topViewController as? SettingsViewController {
                settingsViewController.delegate = self
            } else {
                fatalError("Unexpected Destination View Controller")
            }
        default: break
        }
    }
    
    // MARK: - Actions
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        // dismissing Settings View Controller action
    }
    
    // MARK: - Notification Handling
    
    @objc func applicationDidBecomeActive(notification: Notification) {
        requestLocation()
    }
    
    // MARK: - Helper Methods
    
    private func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(ViewController.applicationDidBecomeActive(notification:)), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    private func requestLocation() {
        // Configure Location Manager
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // Request Current Location
            locationManager.requestLocation()
        } else {
            // Request Authorization
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    fileprivate func fetchWeatherData() {
        guard let location = currentLocation else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        dataManager.weatherDataForLocation(latitude: latitude, longitude: longitude) { (response, error) in
            if let error = error {
                print(error)
            } else if let response = response {
                // Configure Day View Controller
                self.dayViewController.viewModel = DayViewViewModel(weatherData: response)
                // Configure Week View Controller
                self.weekViewController.viewModel = WeekViewViewModel(weatherData: response.dailyData)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: CLLocationManagerDelegate {
    // MARK: - Authorization
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // Request Location
            manager.requestLocation()
        } else {
            // Fall Back to Default Location
            currentLocation = CLLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude)
        }
    }
    
    // MARK: - Location Updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            // Update Current Location
            currentLocation = location
            // Reset Delegate
            manager.delegate = nil
            // Stop Location Manager
            manager.stopUpdatingLocation()
        } else {
            // Fall Back to Default Location
            currentLocation = CLLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        if currentLocation == nil {
            // Fall Back to Default Location
            currentLocation = CLLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude)
        }
    }
}

extension ViewController: DayViewControllerDelegate {
    func controllerDidTapSettingsButton(controller: DayViewController) {
        performSegue(withIdentifier: SegueSettingsView, sender: self)
    }
}

extension ViewController: WeekViewControllerDelegate {
    func controllerDidRefresh(controller: WeekViewController) {
        fetchWeatherData()
    }
}

extension ViewController: SettingsViewControllerDelegate {
    func controllerDidChangeTimeNotation(controller: SettingsViewController) {
        dayViewController.reloadData()
        weekViewController.reloadData()
    }
    
    func controllerDidChangeUnitsNotation(controller: SettingsViewController) {
        dayViewController.reloadData()
        weekViewController.reloadData()
    }
    
    func controllerDidChangeTemperatureNotation(controller: SettingsViewController) {
        dayViewController.reloadData()
        weekViewController.reloadData()
    }
}
