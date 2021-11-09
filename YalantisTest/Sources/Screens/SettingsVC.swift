//
//  SettingsVC.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import UIKit

class SettingsVC: UIViewController {
    
    private var tableView = UITableView()
    
    private let defaults = UserDefaults.standard
    
    private let settingsList: [Setting] = [
        Setting(name: SettingNames.straightPredictions,
                defaultsKey: SettingKeys.straightPredictions,
                hasSwitch: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Cells.settingsCell)
    }
}

extension SettingsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.settingsCell, for: indexPath)
        
        if settingsList[indexPath.row].hasSwitch {
            let cellSwitch = UISwitch(frame: .zero)
            cellSwitch.onTintColor = .systemPink
            cellSwitch.isOn = defaults.bool(forKey: settingsList[indexPath.row].defaultsKey)
            cellSwitch.addTarget(self, action: #selector(toggleSwitch(sender:)), for: .valueChanged)
            cellSwitch.tag = indexPath.row
            
            cell.textLabel?.text = settingsList[indexPath.row].name
            cell.accessoryView = cellSwitch
        } else {
            cell.textLabel?.text = settingsList[indexPath.row].name
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    @objc private func toggleSwitch(sender: UISwitch) {
        defaults.set(sender.isOn, forKey: settingsList[sender.tag].defaultsKey)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
