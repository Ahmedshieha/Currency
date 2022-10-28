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
    
    //    get symbols from viewModel
    func getSymbols () {
        symbolsViewModel.fetchSymbolsFromApi()
    }
    
    //        bind data to pickerView with key or value
    func bindToPickerViews() {
        
        symbolsViewModel.symbolsSubject.bind(to:frompickerView.rx.itemTitles) {(row , element) in
            return element.key
        }.disposed(by: disposeBag)
        
        
        symbolsViewModel.symbolsSubject.bind(to:toPickerView.rx.itemTitles) {(row , element) in
            return element.key
        }.disposed(by: disposeBag)
    }
    
    
}

