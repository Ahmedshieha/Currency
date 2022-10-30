//
//  OtherCurrenciesTableViewCell.swift
//  Currency
//
//  Created by MacBook on 30/10/2022.
//

import UIKit

class OtherCurrenciesTableViewCell: UITableViewCell {

    @IBOutlet weak var fromLable: UILabel!
    @IBOutlet weak var toLable: UILabel!
    
    @IBOutlet weak var amountLable: UILabel!
    
    @IBOutlet weak var resultLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell (from : String , to: String , amount : Int , result : Double ) {
        self.fromLable.text = from
        self.toLable.text = to
        self.amountLable.text = String(amount)
        self.resultLable.text = String(result)
        
        
    }
    
}
