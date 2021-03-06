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
    var books: [PFObject]!
    var check : IndexPath!
//    var selectedPost:PFObject!
    
    let myRefreshControl = UIRefreshControl()
    

    @IBAction func backBt(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        myRefreshControl.addTarget(self, action: #selector(loadNotes), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //

        self.loadNotes()
        }
    
    @objc func loadNotes() {
        let query = PFQuery(className:"Notes")
        query.includeKeys(["UserID", "updatedAt", "content", "bookName"])
        query.whereKey("bookName", equalTo: book)
        query.whereKey("UserID", equalTo: PFUser.current())
        query.addDescendingOrder("LastEdited")
        query.findObjectsInBackground { (notes, error) in
                if notes != nil {
                    self.notes = notes!
                    self.tableView.reloadData()
                }
            }
        self.tableView.reloadData()
        self.myRefreshControl.endRefreshing()
    }
//    func formate (NSTypeDate: NSDate){
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let myString = formatter.string(from: Date())
//        let yourDate = formatter.date(from: myString)
//        formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
//        let myStringafd = formatter.string(from: yourDate!)
//
//        print(myStringafd)
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyNoteCell") as! MyNoteCell
        cell.selectionStyle = .none
        let note = notes[indexPath.row]
//        let user = note["id"] as! PFUser

        cell.noteTitle.text = note["title"] as? String
        cell.theActualNote.text = note["content"] as? String
//        print(note["LastEdited"] as? NSDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, MMM dd yyyy"
        let myStringafd = formatter.string(from: (note["LastEdited"] as? Date)!)
        cell.lastEditTime.text = myStringafd as! String
        
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
                let indexPath : IndexPath
                if let button = sender as? UIButton {
                    let cell = button.superview?.superview as! UITableViewCell
                    let indexPath = tableView.indexPath(for: cell)!
                    let note = notes[indexPath.row]
                    
                    let controller = segue.destination as! EditNoteViewController
                    controller.note = note
                    tableView.deselectRow(at: indexPath, animated: true)
                }
                
//                let cell = sender as! UITableViewCell
//

//                controller.history = self.history
                
            default: break
                
            }
        }
        
    }
}
