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
import DropDown
import Alamofire

class ViewController: UIViewController {
   
    
  
    @IBOutlet weak var amountTextField: UITextField!
    
    
    
    
    @IBOutlet weak var frompickerView: UIPickerView!
    @IBOutlet weak var toPickerView: UIPickerView!
    
    
    let disposeBag = DisposeBag()
    let symbolsViewModel = SymbolViewModel()
    let dropDown = DropDown()
    
    @IBOutlet weak var lable: UILabel!
 
    var array  = Observable.of([:])
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        getSymbols()
//        bindToPickerViews()
//        select()
        getSelected()
        bindResultToLable()
        bindAmountTextFieldToViewModel()
        convertWhenChangeAmount()
        
        
    }
    
  
  func convertWhenChangeAmount() {
        amountTextField.rx.controlEvent([.editingChanged]).asObservable().subscribe({[unowned self] _ in
            converter()
        }).disposed(by: disposeBag)
    }
    
    //    get symbols from viewModel
    func getSymbols () {
        symbolsViewModel.fetchSymbolsFromApi()
    }
    
    func converter() {
        symbolsViewModel.convertCurrency()
    }
    
    func bindResultToLable() {
        
        self.symbolsViewModel.labelSubject.asObservable().map{text -> String? in
            return Optional(text)
        }.bind(to:self.lable.rx.text)
            .disposed(by: disposeBag)
        
    }
    func bindAmountTextFieldToViewModel(){
        amountTextField.rx.text.orEmpty.bind(to: symbolsViewModel.amountTextFieldBehavior).disposed(by: disposeBag)
    }
    
    //        bind data to pickerView with key or value
    
    
    func bindToPickerViews() {
        symbolsViewModel.symbolsSubject.bind(to:frompickerView.rx.itemTitles) {(row , element) in
            return element
        }.disposed(by: disposeBag)

        
        symbolsViewModel.symbolsSubject.bind(to:toPickerView.rx.itemTitles) {(row , element) in
            return element
        }.disposed(by: disposeBag)
        }
    

    
    func getSelected() {
        toPickerView.rx.modelSelected(String.self).subscribe {(event) in

        }.disposed(by: disposeBag)
        
       }
}
