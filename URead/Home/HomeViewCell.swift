//
//  HomeViewCell.swift
//  URead
//
//  Created by Cindy on 11/16/20.
//

import UIKit

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var ivBookpic: UIImageView!
    

    @IBOutlet weak var tvTitle: UILabel!
    
    @IBOutlet weak var tvAuthor: UILabel!
    
    @IBOutlet weak var tvSum: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
