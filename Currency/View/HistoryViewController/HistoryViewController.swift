//
//  HistoryViewController.swift
//  Currency
//
//  Created by MacBook on 29/10/2022.
//

import UIKit
import CoreData
import Foundation
import RxSwift
import RxCocoa



class HistoryViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
     
    @IBOutlet weak var historyTableView: UITableView!
    
    let disposeBag = DisposeBag()
    let viewModel = HistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        subscribeBackButton()
        setUpTableView()
        retriveDataFromCoreData()
        subscribeToResponse()
    }
 
    
    
 
    func subscribeBackButton() {
        backButton.rx.tap.subscribe(onNext : { _ in
            self.dismiss(animated: true, completion: nil)
            
        } ).disposed(by:disposeBag )
    }
    
    func setUpTableView() {
        historyTableView.registerCell(cell: HistoryTableViewCell.self)
    }
    
    func subscribeToResponse() {
        viewModel.transactionSubject.bind(to: self.historyTableView.rx.items(cellIdentifier: "HistoryTableViewCell", cellType: HistoryTableViewCell.self)) {row , transaction , cell in
            cell.configureCell(from: transaction.from ?? "", to: transaction.to ?? "", amount: Int(transaction.amount), result: transaction.result)
        }.disposed(by: disposeBag)
        
    }
    
    func retriveDataFromCoreData () {
        viewModel.retriveDataFromCoreData()
    }
    
    
//    func sectionTable() {
//        let dataSource = RxTableViewSectionedReloadDataSource
//    }
}

    
    

