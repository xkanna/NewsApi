//
//  SingleNewsTableViewController.swift
//  News
//
//  Created by Katarina Veljkovic on 17/07/2020.
//  Copyright © 2020 Katarina Veljkovic. All rights reserved.
//

import UIKit

class SingleNewsTableViewController: UITableViewController {

    struct Constants {
        static fileprivate let headerHeight: CGFloat = 250
    }
    private var data: Article?
    var headerTopConstraint: NSLayoutConstraint!
    var headerHeightConstraint: NSLayoutConstraint!
    var headerImageView: UIImageView!
    let imageView = UIImageView()
    init(datasource: Article) {
        super.init(style: .plain)
        self.data = datasource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        title = "News"
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        imageView.load(url: URL(string: (data?.urlToImage)!)!)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        let headlineTitleLabel = UILabel()
        imageView.addSubview(headlineTitleLabel)
        headlineTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headlineTitleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 130).isActive = true
        headlineTitleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0).isActive = true
        headlineTitleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20).isActive = true
        headlineTitleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0).isActive = true
        headlineTitleLabel.textAlignment = .center
        headlineTitleLabel.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        headlineTitleLabel.textColor = .black
        headlineTitleLabel.numberOfLines = 2
        headlineTitleLabel.text = data?.title

        tableView.register(SingleNewsTableViewCell.self, forCellReuseIdentifier: String(describing: SingleNewsTableViewCell.self))
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: String(describing: ImageTableViewCell.self))
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.alwaysBounceVertical = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SingleNewsTableViewCell.self)) as! SingleNewsTableViewCell
            cell.textView.text = data?.descriptionField
            return cell
        case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImageTableViewCell.self)) as! ImageTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SingleNewsTableViewCell.self)) as! SingleNewsTableViewCell
            cell.textView.text = data?.content
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SingleNewsTableViewCell.self)) as! SingleNewsTableViewCell
            cell.textView.text = data?.publishedAt
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SingleNewsTableViewCell.self)) as! SingleNewsTableViewCell
            cell.textView.text = data?.author
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SingleNewsTableViewCell.self)) as! SingleNewsTableViewCell
            cell.textView.text = data?.url
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SingleNewsTableViewCell.self)) as! SingleNewsTableViewCell
            cell.textView.text = data?.source?.name
            return cell
        default:
            return UITableViewCell()
        }
      }
   /* override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0 {
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
        } else {
            let parallaxFactor: CGFloat = 0.25
            let offsetY = scrollView.contentOffset.y * parallaxFactor
            let minOffsetY: CGFloat = 8.0
            let availableOffset = min(offsetY, minOffsetY)
            let contentRectOffsetY = availableOffset / Constants.headerHeight
            headerTopConstraint?.constant = view.frame.origin.y
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
            headerImageView.layer.contentsRect = CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
            
     }
     
     }*/
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 200 - (scrollView.contentOffset.y )
        let height = min(max(y, 200), 300)
        imageView.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: UIScreen.main.bounds.size.width, height: height)
    }
    
}
