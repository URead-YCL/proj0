//
//  MyBookCell.swift
//  URead
//
//  Created by Cindy on 11/20/20.
//

import UIKit
import Parse


class MyBookCell: UITableViewCell {
    
    @IBOutlet weak var addNote: UIButton!
    @IBOutlet weak var lastTime: UILabel!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var myBookTitle: UILabel!
    @IBOutlet weak var myBookAuthor: UILabel!
//    @IBOutlet weak var myBookSummary: UILabel!
    var books = [PFObject]()
    var users = PFUser.current()
    
    @IBAction func deleteAll(_ sender: Any) {
            let query = PFQuery(className: "Books")
            query.whereKey("title", equalTo: myBookTitle.text)
            query.whereKey("UserID", equalTo: users)
            query.findObjectsInBackground { (books, error) in
            PFObject.deleteAll(inBackground: books)
            
        }
    }
    
    
    @IBAction func addNewNote(_ sender: Any) {
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
