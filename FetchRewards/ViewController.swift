//
//  ViewController.swift
//  FetchRewards
//
//  Created by tejasree vangapalli on 3/5/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import UIKit

//let cellStaticHeight:CGFloat = 55.0 // cell height, except name, skill label and height constraints
//let cellLabelWidth:CGFloat = 150.0 // cell label width, except image and width constraints

class ViewController: UIViewController {
    
    var testData : [dataModal]?
    
    @IBOutlet weak var apiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getDataFromServer()
    }

    // <MARK :- calculate label height for content>
//    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
//        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.text = text
//        label.sizeToFit()
//        
//        return label.frame.height
//    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
        return 200
    }
}

extension ViewController {
    func getDataFromServer() {
        // URL data
        var dataRes: [dataModal]?
        var temp: [dataModal]?
        
        let url_ = URL(string: "https://api.jsonbin.io/b/5e0f707f56e18149ebbebf5f/2")
        var urlreq_ = URLRequest(url: url_!) //Default http - GET
        urlreq_.httpMethod = "GET"
        urlreq_.addValue("$2b$10$Vr2RAD3mpzFZ6o8bPZNlgOOM0LmFLvN24IoxlELo3arTgNszX7otS", forHTTPHeaderField: "secret-key")
                
        URLSession.shared.dataTask(with: urlreq_) {(data, res, err) in
            if data != nil {
                dataRes = try? JSONDecoder().decode([dataModal].self, from: data!)
                temp = dataRes!.filter({
                    return ($0.name != nil && $0.name! != "")
                })
                dataRes = temp!.sorted { (a, b) -> Bool in
                    return a.listId! > b.listId!
                }

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

