//
//  NotesViewController.swift
//  URead
//
//  Created by Cindy on 11/21/20.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var notes = [PFObject]()
    var book: PFObject!
//    var selectedPost:PFObject!
    

    @IBAction func backBt(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className:"Notes")
        query.includeKeys(["UserID", "author", "title", "bookSummary", "bookName"])
        query.whereKey("bookName", equalTo: book)
//        query.whereKey("UserID", equalTo: PFUser.current())
        query.findObjectsInBackground { (notes, error) in
                if notes != nil {
                    self.notes = notes!
                    self.tableView.reloadData()
                }
            }
        tableView.reloadData()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyNoteCell") as! MyNoteCell
        let note = notes[indexPath.row]
//        let user = note["id"] as! PFUser

        cell.noteTitle.text = note["title"] as? String
        cell.theActualNote.text = note["content"] as? String
        
//            let imageFile = post["image"] as! PFFileObject
//            let urlString = imageFile.url!
//            let url = URL(string: urlString)!
//
//            cell.photoView.af_setImage(withURL: url)
            return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        let cell = sender as! UIBarButtonItem
//        let detailsViewController = segue.destination as! NewNoteController
//        detailsViewController.book = book
//
        
        if let identifier = segue.identifier {
            switch identifier {
            case "addSegue":
                let detailsViewController = segue.destination as! UINavigationController
                let actualcontroller = detailsViewController.topViewController as! NewNoteController
                actualcontroller.book = book
            case "editSegue":
                
                let controller = segue.destination as! EditNoteViewController
//                controller.history = self.history
                
            default: break
                
            }
        }
        
    }
}
