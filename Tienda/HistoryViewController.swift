//
//  HistoryViewController.swift
//  Tienda
//
//  Created by Abner Abbey on 01/02/18.
//  Copyright © 2018 Abner Abbey. All rights reserved.
//

import UIKit

protocol HistoryViewControllerDelegate: class {
    func didSelectOption(option: String)
}

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var historyTableView: UITableView!
    var arrayHistory = [String]()
    weak var delegate: HistoryViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if let array = UserDefaults.standard.stringArray(forKey: "history") {
            arrayHistory = array
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arrayHistory[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectOption(option: arrayHistory[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        let doneButton = UIBarButtonItem(title: "Hecho", style: .done, target: self, action: #selector(doneView))
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.title = "Historial"
    }
    
    @objc func doneView() {
        self.dismiss(animated: true, completion: nil)
    }
}
