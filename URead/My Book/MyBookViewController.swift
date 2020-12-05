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
//        query.includeKeys(["author", "comments", "comments.author"])
//        query.limit = 20
        
        query.findObjectsInBackground { (books, error) in
            if books != nil {
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
        cell.myBookAuthor.text = book["author"] as? String
        cell.myBookTitle.text = book["title"] as? String
//        cell.myBookSummary.text = book["bookSummary"] as? String
        
        return cell
    }
    
    
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let book =  books[indexPath.row]

        let detailsViewController = segue.destination as! UINavigationController
        let actualViewController = detailsViewController.topViewController as! NotesViewController
        actualViewController.book = book
        tableView.deselectRow(at: indexPath, animated: true)
    }


//    @IBAction func onLogout(_ sender: Any) {
//        PFUser.logOut()
//        let main = UIStoryboard(name: "Main", bundle: nil)
//        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
//        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
//        delegate.window?.rootViewController = loginViewController
//    }
}
