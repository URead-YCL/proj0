//
//  HomeViewController.swift
//  URead
//
//  Created by Cindy on 11/16/20.
//

import UIKit
import AlamofireImage

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //GOODREAD
//    key: PQFV6Jy1P6yiNCcvmzCfw
//    secret: gks7pfrX1tJmfpFmxzTFaSiNb8SJRZxfcFWX1gtCFg
    
    //Google
    // Key: AIzaSyAnDwfERI10Wm5E4LANV8SJJxuT5mL9Slo
    //247762518399-vmngmcvib04cjdjb0o51ifaemanr21p4.apps.googleusercontent.com
    var books = [[String:Any]]()

    
    @IBOutlet var tableView: UITableView!
    
    
//    "https://www.goodreads.com/search.xml?key=PQFV6Jy1P6yiNCcvmzCfw&q=Ender%27s+Game"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=best+inauthor:keyes&key=AIzaSyAnDwfERI10Wm5E4LANV8SJJxuT5mL9Slo")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        

              // TODO: Get the array of movies
            self.books = dataDictionary["items"] as! [[String:Any]]
            self.tableView.reloadData()
//            print(self.books)

        // Do any additional setup after loading the view.
           }
        }
            task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell") as! HomeViewCell
        
        let movie = books[indexPath.row]
        let base = movie["volumeInfo"] as! [String:Any]
        let title = base["title"] as! String //["title"]
        let authors = base["authors"] as! [String]
        let overview = base["description"] ?? "No Description yet" //["description"]
        let baseURL = "http://books.google.com/books/content?id="
        let endURL = "&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
        
        let poster = movie["id"] as! String
        let posterURL = URL(string: baseURL + poster + endURL)!
        let urlString = baseURL + poster + endURL

        cell.ivBookpic.af_setImage(withURL: posterURL)
        cell.tvTitle.text = title
        cell.tvAuthor.text = authors.joined(separator:", ") 
        cell.tvSum.text = overview as? String
        
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = books[indexPath.row]
        let detailsViewController = segue.destination as! HomeDetailViewController
        detailsViewController.movie = movie
        tableView.deselectRow(at: indexPath, animated: true)
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
