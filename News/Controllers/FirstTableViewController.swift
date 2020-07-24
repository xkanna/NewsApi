//
//  FirstTableViewController.swift
//  News
//
//  Created by Katarina Veljkovic on 17/07/2020.
//  Copyright © 2020 Katarina Veljkovic. All rights reserved.
//

import UIKit

protocol FirstTableViewControllerDelegate: class{
    func done(data: RootClass) -> Void
}

class FirstTableViewController: UITableViewController {

    //var source = Source()
    let session = URLSession.shared
    let url = URL(string: "https://newsapi.org/v2/sources?apiKey=a95b8e3e103a4dcea11b0e8e95ba9a1f")!
    
    private var data: RootClass?
    private var uniqueCategories : [Source] = []
    var checkedSource: [Source] = []
    var categoriesSet: [String] = []
    var checkedData: RootClass?
    
    weak var delegate: FirstTableViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationController?.navigationBar.topItem?.title = "Category"
 
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: String(describing: CategoryTableViewCell.self))
        
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard let self = self else { return }
                //print(error)
                //print(response)
            if error != nil {
                //print(error)
                return
            }
            do {
                let model = try JSONDecoder().decode(RootClass.self, from: data! )
                //print(model)
                
                self.data = model
                DispatchQueue.main.async { [weak self] in
                    self?.removingDuplicates()
                    self?.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        
        task.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoriesSet.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CategoryTableViewCell.self)) as! CategoryTableViewCell
        
        let helper = Array(categoriesSet)[indexPath.row]
        
        cell.categoryLabel.text = helper
        
           return cell
        }
       
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        let sources = data?.sources
        for source in sources! {
            if(source.category == Array(categoriesSet)[indexPath.row]){
                checkedSource.append(source)
            }
        }
    }

    @objc func doneButtonTapped() {
        let vc = SecondTableViewController(datasource: checkedSource)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    func removingDuplicates(){

        var categoriesSett = Set<String>()
        let categories = data?.sources?.compactMap({ $0.category })
        categories?.forEach({ (category) in
            categoriesSett.insert(category)
        })
        categoriesSet = categoriesSett.sorted(by: { $0 < $1 })
    
    }
}
