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
    var arrayOfData : [ConverterModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        subscribeBackButton()
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
        historyTableView.delegate = self
        historyTableView.dataSource = self
        retriveDataFromCoreData()
    }
 
    func subscribeBackButton() {
        backButton.rx.tap.subscribe(onNext : { _ in
            self.dismiss(animated: true, completion: nil)
            
        } ).disposed(by:disposeBag )
    }
    
    
    func retriveDataFromCoreData () {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(ConverterModel.fetchRequest()) as? [ConverterModel] else {return}
            for result in result {
                arrayOfData.append(result)
                historyTableView.reloadData()
            }

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
extension HistoryViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as!
        HistoryTableViewCell
        
        cell.configureCell(from: arrayOfData[indexPath.row].from ?? "", to: arrayOfData[indexPath.row].to ?? "", amount: Int(arrayOfData[indexPath.row].amount ), result: arrayOfData[indexPath.row].result )
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
    
    
}
