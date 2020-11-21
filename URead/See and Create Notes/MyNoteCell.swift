//
//  MyNoteCell.swift
//  URead
//
//  Created by Cindy on 11/21/20.
//

import UIKit

class MyNoteCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var lastEditTime: UILabel!
    @IBOutlet weak var chapter: UILabel!
    @IBOutlet weak var theActualNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
