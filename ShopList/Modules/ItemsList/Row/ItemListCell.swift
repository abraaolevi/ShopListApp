//
//  ItemListCell.swift
//  ShopList
//
//  Created by rapsodo-mobil-5 on 24.10.2019.
//  Copyright © 2019 Abraao Levi. All rights reserved.
//

import UIKit

class ItemListCell: UITableViewCell, CellConfigurable {
    
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? ItemListCellViewModel else {
            return
        }
        lblItemName.text = viewModel.item.name
        lblItemPrice.text = String(describing: viewModel.item.price)
    }
}
