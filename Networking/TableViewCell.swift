//
//  TableViewCell.swift
//  Networking
//
//  Created by Eugene Kiselev on 28.09.2020.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageFromModel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
