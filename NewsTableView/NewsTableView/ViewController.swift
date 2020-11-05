//
//  ViewController.swift
//  NewsTableView
//
//  Created by csc on 2020/06/09.
//  Copyright © 2020 csc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var TableViewMain: UITableView!
    var newsData :Array<Dictionary<String, Any>>?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let news = newsData {
            return news.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        let idx = indexPath.row
        if let news = newsData {
            let row = news[idx]
            if let r = row as? Dictionary<String, Any> {
                if let title = r["title"] as? String {
                    cell.LabelText.text = title
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func getNews() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/top-headlines?country=kr&apiKey=9d5886af0e7d498dab05ea64e67ffa7b")!) { (data, response, error) in
            if let dataJson = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    
                    //Dictionary
                    let articles = json["articles"] as! Array<Dictionary<String, Any>>
                    self.newsData = articles
                    DispatchQueue.main.async {
                       self.TableViewMain.reloadData()
                    }
                } catch {}
                
            }
        }
        task.resume()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
        getNews()
    }


}

