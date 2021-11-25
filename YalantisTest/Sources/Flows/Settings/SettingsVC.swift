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
    
    private var viewModel: SettingsViewModel!
    
    init(viewModel: SettingsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        
        viewModel.loadSettings()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
        tableView.layoutSubviews()
    }
}

extension SettingsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSettings()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsKey.settingsCell, for: indexPath)
        
        let setting = viewModel.setting(at: indexPath.row)
    
        if setting.hasSwitch {
            let cellSwitch = UISwitch(frame: .zero)
            cellSwitch.onTintColor = .systemPink
            cellSwitch.isOn = defaults.bool(forKey: setting.defaultsKey)
            cellSwitch.addTarget(self, action: #selector(toggleSwitch(sender:)), for: .valueChanged)
            cellSwitch.tag = indexPath.row
            
            cell.textLabel?.text = setting.name
            cell.accessoryView = cellSwitch
        } else {
            cell.textLabel?.text = setting.name
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    @objc private func toggleSwitch(sender: UISwitch) {
        defaults.set(sender.isOn, forKey: viewModel.setting(at: sender.tag).defaultsKey)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Private configures and constraints
private extension SettingsVC {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellsKey.settingsCell)
    }
}
