//
//  ArrayExtension.swift
//  News
//
//  Created by Katarina Veljkovic on 20/07/2020.
//  Copyright © 2020 Katarina Veljkovic. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
