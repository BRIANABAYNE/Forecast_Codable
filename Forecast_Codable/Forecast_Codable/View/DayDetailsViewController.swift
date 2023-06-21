//
//  DayDetailsViewController.swift
//  Forecast_Codable
//
//  Created by Karl Pfister on 2/6/22.
//

import UIKit
@available(iOS 16.0, *)

class DayDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var dayForcastTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentHighLabel: UILabel!
    @IBOutlet weak var currentLowLabel: UILabel!
    @IBOutlet weak var currentDescriptionLabel: UILabel!
    
    //MARK: - Properties
    var days: [Day] = []
    var forcastData: TopLevelDictonary?
    
    //MARK: - View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dayForcastTableView.dataSource = self
        
        NetworkContoller.fetchDays { forcastData in
            guard let forcastData = forcastData else {return}
            self.days = forcastData.days
            self.forcastData = forcastData
            DispatchQueue.main.async {
                self.dayForcastTableView.reloadData()
                self.updateViews()
            }
        }
    }
    
    func updateViews() { // don't the instructions for this part?? 
        let day = days[0]
        cityNameLabel.text = "\(day.cityName)"
        currentTempLabel.text = "\(day.temp)"
        currentHighLabel.text = "\(day.highTemp)"
        currentLowLabel.text = "\(day.lowTemp)"
        currentDescriptionLabel.text = day.description
    }
}

//MARK: - Extenstions

@available(iOS 16.0, *)
extension DayDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayC3ll", for: indexPath) as? DayForcastTableViewCell else {return UITableViewCell()}
        let day = days[indexPath.row]
        cell.updateViews(day: day)
        
        return cell
    }
}

