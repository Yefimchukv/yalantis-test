//
//  SettingsVC.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import UIKit

class SettingsVC: UIViewController {
    var tableView = UITableView()
    
    //    let switchCell = UITableViewCell(style: .default, reuseIdentifier: "settingsCell")
    
    let settingsList: [Setting] = [
        Setting(name: "Straight Predictions", defaultsKey: "straightPredictions", isSwitch: true)
    ]
    
    var isStraightModeChosen: Bool?
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        isStraightModeChosen = defaults.bool(forKey: "straightPredictions")
        configureTableView()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingsCell")
    }
    
}

extension SettingsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        
        if settingsList[indexPath.row].isSwitch {
            let cellSwitch = UISwitch(frame: .zero)
            cellSwitch.onTintColor = .systemPink 
            cellSwitch.isOn = defaults.bool(forKey: settingsList[indexPath.row].defaultsKey)
            cellSwitch.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
            
            cell.textLabel?.text = settingsList[indexPath.row].name
            cell.accessoryView = cellSwitch
        } else {
            cell.textLabel?.text = settingsList[indexPath.row].name
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    @objc private func toggleSwitch() {
        print(isStraightModeChosen)
        isStraightModeChosen?.toggle()
        print(isStraightModeChosen)
        defaults.set(isStraightModeChosen, forKey: "straightPredictions")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
