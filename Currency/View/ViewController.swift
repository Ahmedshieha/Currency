//
//  ViewController.swift
//  Currency
//
//  Created by MacBook on 26/10/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation
class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var frompickerView: UIPickerView!
    @IBOutlet weak var toPickerView: UIPickerView!
    
    
    let disposeBag = DisposeBag()
    let symbolsViewModel = SymbolViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getSymbols()
        bindToPickerViews()
    }
    
    
    func getSymbols () {
        symbolsViewModel.getData()
    }
    
    func bindToPickerViews() {
        symbolsViewModel.testSymbols.bind(to:frompickerView.rx.itemTitles) {(row , element) in
            return element.key
        }.disposed(by: disposeBag)
        symbolsViewModel.testSymbols.bind(to:toPickerView.rx.itemTitles) {(row , element) in
            return element.key
        }.disposed(by: disposeBag)
    }
    
    
}

