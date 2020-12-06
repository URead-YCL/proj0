//
//  EditNoteViewController.swift
//  URead
//
//  Created by Cindy on 11/29/20.
//

import UIKit
import Parse

class EditNoteViewController: UIViewController {

    @IBOutlet weak var saveBt: UIBarButtonItem!
    
    @IBOutlet weak var titleEdit: UITextField!
    
    @IBOutlet weak var timeEdit: UILabel!
    
    @IBOutlet weak var noteTextEdit: UITextView!
    
    var note: PFObject!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleEdit.text = note["title"] as! String
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, MMM dd yyyy"
        let myStringafd = formatter.string(from: (note["LastEdited"] as? Date)!)
        timeEdit.text = myStringafd as! String
        noteTextEdit.text = note["content"] as! String
    }
    

    @IBAction func onSave(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        note["title"] = titleEdit.text!
        note["content"] = noteTextEdit.text!
        note["LastEdited"] = NSDate()
        note.saveInBackground { (success, error) in
            if success {
                print("edit successed")
            } else {
                print("error editing note")
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
