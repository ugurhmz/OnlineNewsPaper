//
//  ViewController.swift
//  OnlineNewsPaper
//
//  Created by ugur-pc on 9.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Online Newspaper"
        view.backgroundColor = .systemBackground
        print("wqeqweqw")
        
        
        APIOperation.shared.getTopNews { result in
            
            switch result {
                
                case .success(let response):
                    break
                
                case .failure(let error) :
                    print(error)
                
            }
        }
    }


}

