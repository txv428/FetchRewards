//
//  ViewController.swift
//  FetchRewards
//
//  Created by tejasree vangapalli on 3/5/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataFetched : [[String:AnyObject]]?
    var id: String?
    
    @IBOutlet weak var apiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        id = "2"
        getDataFromServer()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.text1.text = "\(indexPath.item)"
        cell.text2.text = "\(indexPath.row)"
        return cell
    }
}

extension ViewController {
    func getDataFromServer() {
        // URL data
        var dataRes: dataModal?
        
        let url_ = URL(string: "https://api.jsonbin.io/b/5e0f707f56e18149ebbebf5f/%@")
        var urlreq_ = URLRequest(url: url_!) //Default http - GET
        urlreq_.httpMethod = "GET"
        
        // tasks are in suspended state so we need to resume to make it active
        URLSession.shared.dataTask(with: urlreq_) {(data, res, err) in
            var dic = [String: AnyObject]()
            
            if data != nil {
                dataRes = try? JSONDecoder().decode(dataModal.self, from: data!)
                print(dataRes!)
            }
        }.resume()
        
    }
}

