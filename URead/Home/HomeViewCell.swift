//
//  HomeViewCell.swift
//  URead
//
//  Created by Cindy on 11/16/20.
//

import UIKit
import Parse

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var ivBookpic: UIImageView!
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvAuthor: UILabel!
    @IBOutlet weak var tvSum: UILabel!

    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var read: UIButton!
    var liked: Bool = false
    var readed: Bool = false
    var added: Bool = false
    var userID = PFUser.current()!

    
    @IBAction func onAdd(_ sender: Any) {
        let result = !added
        if (result){
            self.setAdd(true)
        } else {
            self.setAdd(false)
        }
        
        
        let newBook = PFObject(className: "Books")
        newBook["title"] = self.tvTitle.text!
        newBook["author"] = self.tvAuthor.text!
        newBook["bookSummary"] = self.tvSum.text!
        newBook["UserID"] = PFUser.current()!
       
       
        newBook.saveInBackground { (success, error) in
            if success {
                print("saved")
            } else {
                print("error saving book")
            }
        }
                   
        
// should not add twice:(((((((((  Write the DatabaseManager later
//        let query = PFQuery(className:"Books").whereKey("author", equalTo: tvAuthor)
////        query.whereKey("title", equalTo: tvTitle)
//        query.findObjectsInBackground (block: { (objects, error) in
//            if (error != nil) {
//                print("error in objects")
//            }
//            if (objects != nil) {
//                print("book existed")
//            } else {
//                let newBook = PFObject(className: "Books")
//                newBook["title"] = self.tvTitle.text!
//                newBook["author"] = self.tvAuthor.text!
//                newBook["bookSummary"] = self.tvSum.text!
//                newBook["UserID"] = PFUser.current()!
//
//
//                newBook.saveInBackground { (success, error) in
//                    if success {
//                        print("saved")
//                    } else {
//                        print("error saving book")
//                    }
//                }
//            }
//        })
//    }
    }
    
    @IBAction func onLike(_ sender: Any) {
        let result = !liked
        if (result){
            self.setLike(true)
        } else {
            self.setLike(false)
        }
        
    }
    
    @IBAction func onRead(_ sender: Any) {
        let result = !readed
        if (result){
            self.setRead(true)
        } else {
            self.setRead(false)
        }
    }
    
    func setAdd(_ faved: Bool) {
        added = faved
        if (added) {
            add.setImage(UIImage(named: "plus"), for: UIControl.State.normal)
            
        }
        else{
            add.setImage(UIImage(named: "minus"), for: UIControl.State.normal)
        }
    }
    
    func setLike(_ reliked: Bool) {
        liked = reliked
        if (liked) {
            like.setImage(UIImage(named: "selected-icon"), for: UIControl.State.normal)
        }
        else{
            like.setImage(UIImage(named: "ok-32"), for: UIControl.State.normal)
        }
    }

    func setRead(_ reread: Bool) {
        readed = reread
        if (readed) {
            read.setImage(UIImage(named: "selected-icon"), for: UIControl.State.normal)
        }
        else{
            read.setImage(UIImage(named: "ok-32"), for: UIControl.State.normal)
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
