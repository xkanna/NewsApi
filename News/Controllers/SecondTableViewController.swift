//
//  SecondTableViewController.swift
//  News
//
//  Created by Katarina Veljkovic on 17/07/2020.
//  Copyright © 2020 Katarina Veljkovic. All rights reserved.
//

import UIKit

class SecondTableViewController: UITableViewController {
    
    private var data: [Source] = []
    
    init(datasource: [Source]) {
        super.init(style: .plain)
        self.data = removeDuplicateElements(posts: datasource)
        data.sort { (data1, data2) -> Bool in
                      data1.name! < data2.name!
           }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        title = "Source"
        
        tableView.register(SourceTableViewCell.self, forCellReuseIdentifier: String(describing: SourceTableViewCell.self))
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SourceTableViewCell.self)) as! SourceTableViewCell
        
        let temp = data[indexPath.row]
        cell.accessoryType = temp.isSelected ? .checkmark : .none
        cell.sourceLabel.text = temp.name
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        data[indexPath.row].isSelected = !data[indexPath.row].isSelected
        tableView.reloadData()
    }
    
    @objc func doneButtonTapped() {
        let checkedSources = data.filter({ $0.isSelected })
        let vc = NewsTableViewController(datasource: checkedSources)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func removeDuplicateElements(posts: [Source]) -> [Source] {
        var uniquePosts = [Source]()
        for post in posts {
            if !uniquePosts.contains(where: {$0.name == post.name }) {
                uniquePosts.append(post)
            }
        }
        return uniquePosts
    }
}
