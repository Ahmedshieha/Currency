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
    
    // outlets
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var frompickerView: UIPickerView!
    @IBOutlet weak var toPickerView: UIPickerView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var otherCurrenciesButton: UIButton!
    
    // disposeBag to neglect variable after you finish bind or subscribe
    let disposeBag = DisposeBag()
    // instance for viewModel
    let homeViewModel = HomeViewModel()
    let jGProgress = JGProgressHUD()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getSymbols()
        bindToPickerViews()
        select()
        bindResultToTextField()
        bindAmountTextFieldToViewModel()
        subscribeToCovertButton()
        subscribeOtherCurrenciesButton ()
        subscribeDetailsButton()
        setUp()
        bintToLoadingIndicator ()
        
        
    }
   
    
    
    // method to bind loadingbehavior from viewModel to jG progress in view based on Bool
    func bintToLoadingIndicator () {
        self.homeViewModel.loadingBehavior.subscribe(onNext : {(isLoading) in
            if isLoading {
                self.jGProgress.show(in: self.view, animated: true)
            } else {
                self.jGProgress.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    
    // method to subscribe details button to display history of transaction
    func subscribeDetailsButton () {
        detailsButton.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance).subscribe (onNext : {  _ in
            let historyViewController = HistoryViewController(nibName: "HistoryViewController", bundle: nil)
            historyViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(historyViewController, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    
     // method to display other currencies after convert success if you don't convert it will display last transaction
    func subscribeOtherCurrenciesButton () {
        otherCurrenciesButton.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance).subscribe (onNext : { [self]  _ in
            let otherCurrenciesViewController = OtherCurrenciesViewController(nibName: "OtherCurrenciesViewController", bundle: nil)
            otherCurrenciesViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(otherCurrenciesViewController, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    
    
   // method to convert from currency to another after choose from pickerView
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
    
    // method to get converter from viewmodel
    func converter() {
        homeViewModel.convertCurrencyFromTo()
    }
    
    // method to bind data from resultSubject viewModel to textField
    func bindResultToTextField() {
        
        self.homeViewModel.resultSubject.asObservable().map{text -> String? in
            return Optional(text)
        }.bind(to:self.toTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    // method to bind data from textField to textFieldBehavior in viewModel
    func bindAmountTextFieldToViewModel(){
        fromTextField.rx.text.orEmpty.bind(to: homeViewModel.fromTextFieldBehavior).disposed(by: disposeBag)
        
        
    }
    
    //        bind data to pickerView with key or value(fromPickerView and ToPickerView)
    func bindToPickerViews() {
        homeViewModel.symbolsSubject.bind(to:frompickerView.rx.itemTitles) {(row , element) in
            return element
        }.disposed(by: disposeBag)
        
        homeViewModel.symbolsSubject.bind(to:toPickerView.rx.itemTitles) {(row , element) in
            return element
        }.disposed(by: disposeBag)
    }

  // method to selet row and value of pickerView when user selct and bind it to viewModel 
    func select() {
        
        toPickerView.rx.itemSelected.map({ row , component in
            self.homeViewModel.symbolsSubject.value[row]
        }).bind(to: self.homeViewModel.toPickerViewBehavior)
            .disposed(by: disposeBag)
        
        frompickerView.rx.itemSelected.map({row , component in
            self.homeViewModel.symbolsSubject.value[row]
        }).bind(to: self.homeViewModel.fromPickerViewBehavior).disposed(by: disposeBag)
        
        
    }
    // method to setUp buttons and JGProgress lable
    func setUp () {
        self.convertButton.layer.cornerRadius = 10
        self.convertButton.backgroundColor = .lightGray
        
        self.detailsButton.layer.cornerRadius = 10
        self.detailsButton.backgroundColor = .lightGray
        
        self.otherCurrenciesButton.layer.cornerRadius = 10
        self.otherCurrenciesButton.backgroundColor = .lightGray
        self.jGProgress.textLabel.text = "Loading"
        
    }
}





