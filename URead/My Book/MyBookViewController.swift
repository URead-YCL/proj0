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

    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = books[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyBookCell") as! MyBookCell
        
        cell.myBookAuthor.text = book["author"] as? String
        cell.myBookTitle.text = book["title"] as? String
        cell.myBookSummary.text = book["bookSummary"] as? String
        
        return cell
        
        
        
//        cell.myBookAuthor.text = "LILI"
//        cell.myBookSummary.text = "hahah"
//        cell.myBookTitle.text = "thisistheTitle"
//        let note = notes[indexPath.row]
//        let user = note["id"] as! PFUser
//
//        cell.myBookSummary.text = post["caption"] as! String
//
//        let imageFile = post["image"] as! PFFileObject
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)!
//
//        cell.photoView.af_setImage(withURL: url)
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Books")
        query.includeKeys(["author", "UserID", "title", "bookSummary"])
        
        query.findObjectsInBackground { (books, error) in
            if books != nil {
                self.books = books!
                self.tableView.reloadData()
            }
        }
    
    }
    

    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
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
