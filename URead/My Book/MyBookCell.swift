//
//  MyBookCell.swift
//  URead
//
//  Created by Cindy on 11/20/20.
//

import UIKit

class MyBookCell: UITableViewCell {
    @IBOutlet weak var myBookPic: UIImageView!
    @IBOutlet weak var myBookTitle: UILabel!
    @IBOutlet weak var myBookAuthor: UILabel!
    @IBOutlet weak var myBookSummary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
