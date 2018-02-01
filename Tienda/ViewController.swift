//
//  ViewController.swift
//  Liverpool
//
//  Created by Abner Abbey on 01/02/18.
//  Copyright © 2018 Abner Abbey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchProductBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var productViewModel: ProductViewModel?
    var searchString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let historyButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(toHistoryView))
        self.navigationItem.leftBarButtonItem = historyButton
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchProductBar.delegate = self
    }
    
    @objc func toHistoryView() {
        guard let nextView = self.storyboard?.instantiateViewController(withIdentifier: "history") else { return }
        let nv = UINavigationController(rootViewController: nextView)
        present(nv, animated: true, completion: nil)
    }
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: Table View DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = productViewModel?.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = productViewModel?.sections[section] {
            return section.rows
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = productViewModel?.sections[indexPath.section] as? ProductsViewModelResultItem, let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        let product = item.results[indexPath.row]
        cell.item = product
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    //MARK: Search Bar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if var arrayHistory = UserDefaults.standard.stringArray(forKey: "history") {
            arrayHistory.append(searchString)
            UserDefaults.standard.set(arrayHistory, forKey: "history")
        } else {
            let arrayHistory = [searchString]
            UserDefaults.standard.set(arrayHistory, forKey: "history")
        }
        let manager = ServiceManager()
        manager.requestData(fromSearch: searchString) { (data) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.productViewModel = ProductViewModel(data: data)
                self.searchTableView.reloadData()
            }
        }
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
