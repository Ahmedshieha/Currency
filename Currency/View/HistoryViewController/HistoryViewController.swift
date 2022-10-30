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

import RxDataSources


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
    
    // method to dismiss historyViewController
    func subscribeBackButton() {
        backButton.rx.tap.subscribe(onNext : { _ in
            self.dismiss(animated: true, completion: nil)
            
        } ).disposed(by:disposeBag )
    }
    
    // setUp tableView
    func setUpTableView() {
        historyTableView.registerCell(cell: HistoryTableViewCell.self)
    }
    
    // bind data to tableView from viewModel
    func subscribeToResponse() {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(configureCell: { dataSource, tableView, indexPath, transaction in
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
            cell.configureCell(from: transaction.from ?? "", to: transaction.to ?? "", amount: Int(transaction.amount), result: transaction.result)
            return cell
        })
        dataSource.titleForHeaderInSection = { dataSource , indexPath in
            return dataSource.sectionModels[indexPath].header
        }
        
        viewModel.currenciesObservabale().bind(to: historyTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
    }
    
    // fetchData from viewModel
    func retriveDataFromCoreData () {
        viewModel.retriveDataFromCoreData()
    }
    
    
}





struct SectionOfCustomData {
    var header: String
    var items: [Item]
}
extension SectionOfCustomData: SectionModelType {
    typealias Item = ConverterModel
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
