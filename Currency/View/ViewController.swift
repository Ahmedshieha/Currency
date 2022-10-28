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

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var frompickerView: UIPickerView!
    @IBOutlet weak var toPickerView: UIPickerView!
    
    
    let disposeBag = DisposeBag()
    let symbolsViewModel = SymbolViewModel()
    let dropDown = DropDown()
    
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var vDropDown: UIView!
    var array  = Observable.of([:])
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        getSymbols()
//        bindToPickerViews()
//        select()
//                getSelected()
        let testConvert = ApiService()
        testConvert.conver { result in
            switch result {
            case.success(let converter ) :
                print(converter.result)
            case.failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    @IBAction func showDropDown(_ sender: Any) {
        dropDown.show()
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
    
    
    
//    func select () {
//
//        frompickerView.rx.itemSelected.subscribe { (event) in
//
//            switch event {
//
//            case.next(let selected) :
//                self.lable.text = String(selected.row)
//                print(selected.row)
//
//            default:
//                break
//            }
//        }.disposed(by: disposeBag)
//
//
//    }
    
    func getSelected() {
        toPickerView.rx.modelSelected(NSDictionary.self).subscribe {(event) in
            
            switch event {
            case.next(let value) :
                print(value)
            default:
                break
            }
        }
       }
}
