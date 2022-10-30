//
//  OtherCurrenciesViewController.swift
//  Currency
//
//  Created by MacBook on 30/10/2022.
//

import UIKit
import RxSwift
import RxCocoa

class OtherCurrenciesViewController: UIViewController {
    // outlets
    @IBOutlet private var backButton : UIButton!
    @IBOutlet weak var otherCurrenciesTebleView: UITableView!
    
    let disposeBag = DisposeBag()
    let otherCurrenciesViewModel = OtherCurrenciesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        subscribeBackButton()
        fetchData()
        subscribeToRespone()
        setUpTableView()
    }
    
    
    // method for dismiss otherCurrenciesviewController
    func subscribeBackButton() {
        backButton.rx.tap.subscribe(onNext : { _ in
            self.dismiss(animated: true, completion: nil)
            
        } ).disposed(by:disposeBag )
    }
    
    // fetch data from viewModel
    func fetchData () {
        otherCurrenciesViewModel.getOtherCurrencies()
    }
    
    // setup tableView
    func setUpTableView() {
        otherCurrenciesTebleView.registerCell(cell: OtherCurrenciesTableViewCell.self)
    }
    
    // method to bind data to tableView
    func subscribeToRespone () {
        self.otherCurrenciesViewModel.transactionSubject.bind(to: otherCurrenciesTebleView.rx.items(cellIdentifier: "OtherCurrenciesTableViewCell", cellType: OtherCurrenciesTableViewCell.self)) {row , data , cell in
            let base = UserDefaults.standard.value(forKey: "base")
            let amount = UserDefaults.standard.integer(forKey: "amount")
            cell.configureCell(from: base as! String, to: data.key, amount: amount, result: data.value*Double(amount))
        }.disposed(by: disposeBag)
    }
    
}
