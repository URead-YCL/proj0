//
//  NewNoteController.swift
//  URead
//
//  Created by Cindy on 11/20/20.
//

import UIKit
import AlamofireImage
import Parse

class NewNoteController: UIViewController, UINavigationControllerDelegate{

    @IBOutlet weak var tvTitle: UITextField!
    @IBOutlet weak var tvNote: UITextView!
    var book:PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    @IBAction func DoneBt(_ sender: Any) {
        let note = PFObject(className: "Notes")
        note["title"] = tvTitle.text!
        note["content"] = tvNote.text!
        note["UserID"] = PFUser.current()!
        note["bookName"] = book
//        print("hello myworld!!!!!!!!!")
//        print(book)
        
        
        note.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            } else {
                print("error saving")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
