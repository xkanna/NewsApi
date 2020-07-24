//
//  NewsTableViewController.swift
//  News
//
//  Created by Katarina Veljkovic on 17/07/2020.
//  Copyright © 2020 Katarina Veljkovic. All rights reserved.
//

import UIKit


class NewsTableViewController: UITableViewController {
    
    let session = URLSession.shared
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=a95b8e3e103a4dcea11b0e8e95ba9a1f")!
    
    private var data : ArticlesData?
    private var articles : [Article] = []
    private var sources: [Source] = []
    var newsSet = Set<String>()
    
    init(datasource: [Source]) {
        super.init(style: .plain)
        self.sources = datasource
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        
        tableView.register(SourceTableViewCell.self, forCellReuseIdentifier: String(describing: SourceTableViewCell.self))
        
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard let self = self else { return }
            //print(error)
            //print(response)
            if error != nil {
                //print(error)
                return
            }
            do {
                let model = try JSONDecoder().decode(ArticlesData.self, from: data! )
                
                self.data = model
                
                DispatchQueue.main.async { [weak self] in
                    for article in (self?.data?.articles!)!{
                        for source in self!.sources{
                            if(article.source?.name == source.name){
                                self!.articles.append(article)
                            }
                        }
                    }
                    self?.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SourceTableViewCell.self)) as! SourceTableViewCell
        
        cell.sourceLabel.text = articles[indexPath.row].title
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SingleNewsTableViewController(datasource: articles[indexPath.row] )
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func removingDuplicates(){
        
        let names = articles.compactMap({ $0.title })
        names.forEach({ (title) in
            newsSet.insert(title)
        })
        
    }
    
    /*func someFunctionThatTakesAClosure(closure: (Int, String, Error?) -> Void) {
        
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard let self = self else { return }
            //print(error)
            //print(response)
            if error != nil {
                //print(error)
                return
            }
            do {
                let model = try JSONDecoder().decode(ArticlesData.self, from: data! )
                
                self.data = model
                
                DispatchQueue.main.async { [weak self] in
                    closure(2, "3", nil)
                    self?.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        
        task.resume()
    }*/
    
}
