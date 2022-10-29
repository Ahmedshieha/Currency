//
//  HistoryTableViewCell.swift
//  Currency
//
//  Created by MacBook on 29/10/2022.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var fromLable: UILabel!
    @IBOutlet weak var toLable: UILabel!
    
    
    @IBOutlet weak var resultLAble: UILabel!
    @IBOutlet weak var amountLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell (from :String , to :String , amount : Int , result : Double) {
        self.fromLable.text = from
        self.toLable.text = to
        self.amountLable.text = String(amount)
        self.resultLAble.text = String(result)
        
    }
    
}
