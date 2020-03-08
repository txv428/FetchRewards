//
//  ViewController.swift
//  FetchRewards
//
//  Created by tejasree vangapalli on 3/5/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import UIKit

let cellStaticHeight:CGFloat = 55.0 // cell height, except name, skill label and height constraints
let cellLabelWidth:CGFloat = 150.0 // cell label width, except image and width constraints

class ViewController: UIViewController {
    
    var testData = dataModal()
    
    @IBOutlet weak var apiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getDataFromServer()
    }
    
    // <MARK :- calculate label height for content>
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = testData.data {
            print(data.count)
            return data.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        if let data_ = testData.data {
            print("data_ \(data_)")
            let data = data_[indexPath.row]
            cell.text1.text = data.name
            cell.text2.text = data.skills
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
        var dataRes: dataModal?
        
        let url_ = URL(string: "https://test-api.nevaventures.com/")
        var urlreq_ = URLRequest(url: url_!) //Default http - GET
        urlreq_.httpMethod = "GET"
        
        // tasks are in suspended state so we need to resume to make it active
        URLSession.shared.dataTask(with: urlreq_) {(data, res, err) in
            if data != nil {
                dataRes = try? JSONDecoder().decode(dataModal.self, from: data!)
                self.testData = dataRes!
                DispatchQueue.main.async {
                    self.apiTableView.reloadData()
                }
//                self.apiTableView.reloadData()
            }
        }.resume()
    }
}

