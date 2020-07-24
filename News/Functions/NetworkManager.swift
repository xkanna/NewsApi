//
//  NetworkManager.swift
//  News
//
//  Created by Katarina Veljkovic on 24/07/2020.
//  Copyright © 2020 Katarina Veljkovic. All rights reserved.
//

import Foundation

class NetworkManager {

    let url: URL
    let session = URLSession.shared

    private init(baseURL: URL) {
        self.url = baseURL
    }
    
    func someFunctionThatTakesAClosure(data: (RootClass) -> Void) {
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
                    
                    //data = model
                    DispatchQueue.main.async { [weak self] in
                        //self?.removingDuplicates()
                        //self?.tableView.reloadData()
                    }
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            })
            
            task.resume()
        }
    }
    

