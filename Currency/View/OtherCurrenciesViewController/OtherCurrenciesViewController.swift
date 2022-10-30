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

    @IBOutlet private var backButton : UIButton!
    
    @IBOutlet weak var otherCurrenciesTebleView: UITableView!
    let disposeBag = DisposeBag()
    let otherCurrenciesViewModel = OtherCurrenciesViewModel()
    let homeViewModel = HomeViewModel()
    
    let pickerViewBehavior = PublishSubject<String>()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        subscribeBackButton()
        fetchData()
        subscribeToRespone()
        setUpTableView()
    }
        
        
        
        func subscribeBackButton() {
            backButton.rx.tap.subscribe(onNext : { _ in
                self.dismiss(animated: true, completion: nil)
                
            } ).disposed(by:disposeBag )
        }

    func fetchData () {
        otherCurrenciesViewModel.getOtherCurrencies()
    }
    func setUpTableView() {
        otherCurrenciesTebleView.registerCell(cell: OtherCurrenciesTableViewCell.self)
    }
    
    func subscribeToRespone () {

        self.otherCurrenciesViewModel.transactionSubject.bind(to: otherCurrenciesTebleView.rx.items(cellIdentifier: "OtherCurrenciesTableViewCell", cellType: OtherCurrenciesTableViewCell.self)) {row , data , cell in
            let base = UserDefaults.standard.value(forKey: "base")
            let amount = UserDefaults.standard.integer(forKey: "amount")
            cell.configureCell(from: base as! String, to: data.key, amount: amount, result: data.value*Double(amount))
        }.disposed(by: disposeBag)
        
    }
    
    func commaSeparatedList(list: [String]) -> String {
        var outputString: String = ""
        for element in list {
            outputString.append(element + ",")
        }
        outputString.removeLast()
        print(outputString)
        return outputString
    }

}
