//
//  RealmWc.swift
//  -18-03-24
//
//  Created by swift on 18.03.2024.
//

import UIKit
import RealmSwift

class RealmVc: UIViewController {
    
    let realm = try! Realm()
    
    var countries = [Country]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var textField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "insert text"
        return textfield
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "some text"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("tap me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(setName), for: .touchDragInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        //        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getCountries()
    }
    
    private func setupViews() {
        view.addSubview(textField)
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(textField.snp.bottom).offset(12)
            
        }
        
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(12)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(button.snp.bottom).offset(12)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func buttonTapped() {
        //        print(textField.text)
        var country = Country()
        country.name = textField.text ?? ""
        textField.text = ""
        try! realm.write {
            realm.add(country)
        }
        getCountries()
    }
    
    @objc func setName() {
        getCountries()
    }
    
    
    private func getCountries() {
        let countries = realm.objects(Country.self)
        
        self.countries = countries.map({ country in
            country
        })
    }
    
    private func deleteCountry(_ country: Country) {
        try! realm.write {
            realm.delete(country)
        }
    }
    
    private func updateCountryName(to name: String, at index: Int) {
        
        let country = realm.objects(Country.self)[index]
        
        try! realm.write({
            country.name = name
        })
    }
    
    
    
}

extension RealmVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, completionHandler) in
            // Handle edit action
            self?.editCountry(at: indexPath)
            completionHandler(true)
        }
        editAction.backgroundColor = .blue
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            // Handle delete action
            self?.deleteCountry(at: indexPath)
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    private func editCountry(at indexPath: IndexPath) {
        updateCountryName(to: textField.text ?? "", at: indexPath.row)
        textField.text = ""
        getCountries()
        
    }
    
    private func deleteCountry(at indexPath: IndexPath) {
        let country = countries[indexPath.row]
        deleteCountry(country)
        getCountries()
        
    }
}
