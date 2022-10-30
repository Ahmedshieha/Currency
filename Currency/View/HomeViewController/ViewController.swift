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
import JGProgressHUD

class ViewController: UIViewController {
    
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var frompickerView: UIPickerView!
    @IBOutlet weak var toPickerView: UIPickerView!
    
    @IBOutlet weak var detailsButton: UIButton!
    
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var otherCurrenciesButton: UIButton!
    
    let disposeBag = DisposeBag()
    let homeViewModel = HomeViewModel()
    let jGProgress = JGProgressHUD()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getSymbols()
        bindToPickerViews()
        select()
        bindResultToLable()
        bindAmountTextFieldToViewModel()
        subscribeToCovertButton()
        subscribeOtherCurrenciesButton ()
        fetchTransaction()
        subscribeDetailsButton()
        setUp()
        bintToLoadingIndicator ()
        
        
    }
    
    func setUp () {
        self.convertButton.layer.cornerRadius = 10
        self.convertButton.backgroundColor = .lightGray
        
        self.detailsButton.layer.cornerRadius = 10
        self.detailsButton.backgroundColor = .lightGray
        
        self.otherCurrenciesButton.layer.cornerRadius = 10
        self.otherCurrenciesButton.backgroundColor = .lightGray
        self.jGProgress.textLabel.text = "Loading"
        
    }
    
    
    func bintToLoadingIndicator () {
        self.homeViewModel.loadingBehavior.subscribe(onNext : {(isLoading) in
            
            if isLoading {
                self.jGProgress.show(in: self.view, animated: true)
            } else {
                self.jGProgress.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    
    
    
    func fetchTransaction () {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(ConverterModel.fetchRequest()) as? [ConverterModel] else {return}
            result.forEach({print($0.result)})
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func subscribeDetailsButton () {
        detailsButton.rx.tap.subscribe (onNext : {  _ in
            
            
            let historyViewController = HistoryViewController(nibName: "HistoryViewController", bundle: nil)
            historyViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(historyViewController, animated: true, completion: nil)
                                        
                                        
            }).disposed(by: disposeBag)
    }
    func subscribeOtherCurrenciesButton () {
        
        
        otherCurrenciesButton.rx.tap.subscribe (onNext : { [self]  _ in
            let otherCurrenciesViewController = OtherCurrenciesViewController(nibName: "OtherCurrenciesViewController", bundle: nil)
            otherCurrenciesViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(otherCurrenciesViewController, animated: true, completion: nil)
            
                                        
            }).disposed(by: disposeBag)
        
       
    }
    func subscribeToCovertButton() {
        convertButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance).subscribe(onNext : {[weak self](_) in
            guard let self = self else {return}
            self.converter()
        }).disposed(by: disposeBag)
    }
    
    
    //    get symbols from viewModel
    func getSymbols () {
        homeViewModel.fetchSymbolsFromApi()
    }
    
    func converter() {
        homeViewModel.convertCurrencyFromTo()
    }
    
    func bindResultToLable() {
        
        self.homeViewModel.resultSubject.asObservable().map{text -> String? in
            return Optional(text)
        }.bind(to:self.toTextField.rx.text)
            .disposed(by: disposeBag)
    }
    func bindAmountTextFieldToViewModel(){
        fromTextField.rx.text.orEmpty.bind(to: homeViewModel.fromTextFieldBehavior).disposed(by: disposeBag)
        
        
    }
    
    //        bind data to pickerView with key or value
    
    
    func bindToPickerViews() {
        homeViewModel.symbolsSubject.bind(to:frompickerView.rx.itemTitles) {(row , element) in
            
            return element
        }.disposed(by: disposeBag)
        
        
        homeViewModel.symbolsSubject.bind(to:toPickerView.rx.itemTitles) {(row , element) in
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
        
        toPickerView.rx.itemSelected.map({ row , component in
            self.homeViewModel.symbolsSubject.value[row]
        }).bind(to: self.homeViewModel.toPickerViewBehavior)
            .disposed(by: disposeBag)
        
        frompickerView.rx.itemSelected.map({row , component in
            self.homeViewModel.symbolsSubject.value[row]
        }).bind(to: self.homeViewModel.fromPickerViewBehavior).disposed(by: disposeBag)
        
        
    }
}





