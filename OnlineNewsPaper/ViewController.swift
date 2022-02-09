//
//  ViewController.swift
//  OnlineNewsPaper
//
//  Created by ugur-pc on 9.02.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    // tableView register
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "mycell")
        
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Online Newspaper"
        view.backgroundColor = .systemBackground
        print("wqeqweqw")
        
        
        // API DATAS
        APIOperation.shared.getTopNews { result in
            
            switch result {
                
                case .success(let response):
                    break
                
                case .failure(let error) :
                    print(error)
                
            }
        }
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    
    
    
    
    
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell",
                                                 for : indexPath)
        
        cell.textLabel?.text = "Test"
        return cell
    }
    
    
    // didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

