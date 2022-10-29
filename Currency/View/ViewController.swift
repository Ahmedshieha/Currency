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
import Alamofire

class ViewController: UIViewController {
   
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var frompickerView: UIPickerView!
    @IBOutlet weak var toPickerView: UIPickerView!

    
    @IBOutlet weak var convertButton: UIButton!
    
    let disposeBag = DisposeBag()
    let symbolsViewModel = SymbolViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getSymbols()
        bindToPickerViews()
        select()
        bindResultToLable()
        bindAmountTextFieldToViewModel()
        subscribeToCovertButton()
        
}
    func subscribeToCovertButton() {
        convertButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance).subscribe(onNext : {[weak self](_) in
            guard let self = self else {return}
            self.converter()
        }).disposed(by: disposeBag)
    }
  
    
    //    get symbols from viewModel
    func getSymbols () {
        symbolsViewModel.fetchSymbolsFromApi()
    }
    
    func converter() {
        symbolsViewModel.convertCurrencyFromTo()
    }
    
    func bindResultToLable() {
        
        self.symbolsViewModel.resultSubject.asObservable().map{text -> String? in
            return Optional(text)
        }.bind(to:self.toTextField.rx.text)
            .disposed(by: disposeBag)
    }
    func bindAmountTextFieldToViewModel(){
        fromTextField.rx.text.orEmpty.bind(to: symbolsViewModel.fromTextFieldBehavior).disposed(by: disposeBag)
        
        
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
    
    func bindToPickerFromJson() {
        currenciesarray.bind(to:frompickerView.rx.itemTitles) {(row , element) in
            return element
        }.disposed(by: disposeBag)

        
        currenciesarray.bind(to:toPickerView.rx.itemTitles) {(row , element) in
            return element
        }.disposed(by: disposeBag)
    }
    
    func select() {

        toPickerView.rx.itemSelected.map({row , component in
            self.symbolsViewModel.symbolsSubject.value[row]
        }).bind(to: self.symbolsViewModel.toPickerViewBehavior).disposed(by: disposeBag)
        
        frompickerView.rx.itemSelected.map({row , component in
            self.symbolsViewModel.symbolsSubject.value[row]
        }).bind(to: self.symbolsViewModel.fromPickerViewBehavior).disposed(by: disposeBag)

   
       }
}





