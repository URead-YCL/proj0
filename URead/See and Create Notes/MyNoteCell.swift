//
//  MyNoteCell.swift
//  URead
//
//  Created by Cindy on 11/21/20.
//

import UIKit
import Parse

class MyNoteCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var lastEditTime: UILabel!
    @IBOutlet weak var chapter: UILabel!
    @IBOutlet weak var theActualNote: UILabel!
    @IBOutlet weak var editbt: UIButton!
    @IBOutlet weak var deletebt: UIButton!
    
    
    @IBAction func onEdit(_ sender: Any) {
    }
    
    @IBAction func onDelete(_ sender: Any) {
        let query = PFQuery(className: "Notes")
        query.whereKey("UserID", equalTo: PFUser.current())
        query.whereKey("title", equalTo: noteTitle.text)
        query.whereKey("content", contains: theActualNote.text)
        query.findObjectsInBackground { (notes, error) in
        PFObject.deleteAll(inBackground: notes)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
