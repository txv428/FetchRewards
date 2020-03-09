//
//  ViewController.swift
//  FetchRewards
//
//  Created by tejasree vangapalli on 3/5/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var testData : [dataModal]?
    
    @IBOutlet weak var apiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getDataFromServer()
    }
}

// UI operations to fill the data into table
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // number of records in the final data
        if let data = testData {
            return data.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        if let data_ = testData {
            let data = data_[indexPath.row]
            cell.name.text = data.name
            cell.id.text = "\(data.id!)"
            cell.listId.text = "\(data.listId!)"
        }
        
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // height of each cell
        return 150
    }
}

// GET request make an API call and fetch the json data using JSONDecoder
extension ViewController {
    func getDataFromServer() {
        // URL data
        var dataRes: [dataModal]?
        var temp: [dataModal]?
        
        let url_ = URL(string: "https://api.jsonbin.io/b/5e0f707f56e18149ebbebf5f/2")
        var urlreq_ = URLRequest(url: url_!)
        // http - GET request
        urlreq_.httpMethod = "GET"
        urlreq_.addValue("$2b$10$Vr2RAD3mpzFZ6o8bPZNlgOOM0LmFLvN24IoxlELo3arTgNszX7otS", forHTTPHeaderField: "secret-key")
                
        URLSession.shared.dataTask(with: urlreq_) {(data, res, err) in
            if data != nil {
                // dataRes is the data fetched from the API
                dataRes = try? JSONDecoder().decode([dataModal].self, from: data!)
                // Filtering the records with nill or empty name
                temp = dataRes!.filter({
                    return ($0.name != nil && $0.name! != "")
                })
                // sorting the records with listID using sorted higherorder function
                dataRes = temp!.sorted { (a, b) -> Bool in
                    return a.listId! > b.listId!
                }
                // sorting the records using name and having same listId
                self.testData = dataRes!.sorted {
                    if $0.listId! == $1.listId! {
                        return $0.name! < $1.name!
                    }
                    else {
                        return true
                    }
                }
                DispatchQueue.main.async {
                    self.apiTableView.reloadData()
                }
            }
            // tasks are in suspended state so we need to resume to make it active
        }.resume()
    }
}

