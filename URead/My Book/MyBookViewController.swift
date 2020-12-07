//
//  MyBookViewController.swift
//  URead
//
//  Created by Cindy on 11/16/20.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class MyBookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isbn: String = ""
    var books = [PFObject]()
    var selectedPost:PFObject!
    var user = PFUser.current()
    var index:UITableViewCell!

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //doing
        NotificationCenter.default.addObserver(self, selector: Selector(("reloadData:")),name:NSNotification.Name(rawValue: "reloadData"), object: nil)
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Books")
        query.includeKeys(["author", "UserID", "title", "bookSummary"])
        query.whereKey("UserID", equalTo: PFUser.current())
        query.addDescendingOrder("TimeStamp")
//        query.includeKeys(["author", "comments", "comments.author"])
//        query.limit = 20
        
        query.findObjectsInBackground { (books, error) in
            if books != nil  {
                self.books = books!
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = books[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyBookCell") as! MyBookCell
        cell.selectionStyle = .none
        cell.myBookAuthor.text = book["author"] as? String
        cell.myBookTitle.text = book["title"] as? String
//        cell.myBookSummary.text = book["bookSummary"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, MMM dd yyyy"
        let myStringafd = formatter.string(from: (book["TimeStamp"] as? Date)!)
        cell.lastTime.text = myStringafd as! String
        
        return cell
    }
    
    @IBAction func scanBt(_ sender: Any) {
    }
    
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
            
            if let identifier = segue.identifier {
                switch identifier {
                case "toNote":
                    let indexPath : IndexPath
                    if let button = sender as? UIButton {
                        let cell = button.superview?.superview as! UITableViewCell
                        let indexPath = tableView.indexPath(for: cell)!
                        let book =  books[indexPath.row]
                        print(indexPath)
                        let detailsViewController = segue.destination as! UINavigationController
                        let actualViewController = detailsViewController.topViewController as! NotesViewController
                        actualViewController.book = book
                        actualViewController.books = books
                        tableView.deselectRow(at: indexPath, animated: true)
                    }
                    
                    
                case "toScanner":
                    
                    let controller = segue.destination as! ScannerController
    //                controller.history = self.history
                    
                default: break
                    
                }
            }
            
    }


//    @IBAction func onLogout(_ sender: Any) {
//        PFUser.logOut()
//        let main = UIStoryboard(name: "Main", bundle: nil)
//        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
//        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
//        delegate.window?.rootViewController = loginViewController
//    }
}
