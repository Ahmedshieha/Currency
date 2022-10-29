//
//  TableView+extensions.swift
//  Currency
//
//  Created by MacBook on 29/10/2022.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell<Cell : UITableViewCell>(cell: Cell.Type) {
        let nibName = String(describing: Cell.self)
        let cell = UINib(nibName: nibName, bundle: nil)
        self.register(cell, forCellReuseIdentifier: nibName)
     
    }
}
