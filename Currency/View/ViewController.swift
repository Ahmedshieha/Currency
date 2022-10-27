//
//  ViewController.swift
//  Currency
//
//  Created by MacBook on 26/10/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }

    
    func getData () {
        ApiService.shared.getSymbols { result  in
            switch result {
            case.success(let symbols) :
                for symbol in symbols.symbols {
                    print(symbol.key)
                }
//                print(symbols)
            case.failure(let error) :
                print(error.localizedDescription)
            }
            
        }
    }

}

