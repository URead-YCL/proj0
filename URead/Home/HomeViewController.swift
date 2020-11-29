//
//  HomeViewController.swift
//  URead
//
//  Created by Cindy on 11/16/20.
//

import UIKit
import AlamofireImage

class HomeViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    let baseUrl  = "https://www.googleapis.com/books/v1/volumes?q=a"
    var booksFound = [[String: Any]]()
    
    
    struct Book {
        let bookIsbn : String
        let bookTitle: String
        let bookAuthor: String
        let description : String
        let id : String
        let bookImage: Image
        let liked : Bool
        let readed : Bool
        let added: Bool
    }
    
    //GOODREAD
//    key: PQFV6Jy1P6yiNCcvmzCfw
//    secret: gks7pfrX1tJmfpFmxzTFaSiNb8SJRZxfcFWX1gtCFg
    
    // Google
    // Key: AIzaSyAnDwfERI10Wm5E4LANV8SJJxuT5mL9Slo
    // 247762518399-vmngmcvib04cjdjb0o51ifaemanr21p4.apps.googleusercontent.com
    
    //local
    //file:///Users/CC/Desktop/books-isbn.json
//    var basicbooks = [[String:Any]]()
//    var books = [[String:Any]]()

    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        queryBooks(bookTitle: "a")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let book = booksFound[indexPath.row]
        let detailsViewController = segue.destination as! HomeDetailViewController
        detailsViewController.book = book
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
    
}

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksFound.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell") as! HomeViewCell
        let book = self.booksFound[indexPath.row]
        if let base = self.booksFound[indexPath.row]["volumeInfo"] as? [String: Any] {
            let id = book["id"] as! String
            let title = base["title"] as! String
            let authors = base["authors"] as? [String]
    
            let overview = base["description"] ?? "No offical description yet, view more detail on Google"
            let imagesfirst = "http://books.google.com/books/content?id="
            let imagelast = "&printsec=frontcover&img=1"
            let imageUrl = URL(string: imagesfirst + id + imagelast)!
    
            let identifier = base["industryIdentifiers"] as! [[String:String]]
            let isbn13 = identifier[0]["identifier"]!
    
            cell.ivBookpic.af_setImage(withURL: imageUrl)
            cell.tvTitle.text = title
            
            if authors == nil{
                cell.tvAuthor.text = "Unknown"
            } else {
                cell.tvAuthor.text = authors?.joined(separator:", ")
            }
            cell.tvSum.text = overview as? String
        
        }
        return cell
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let bookTitle = searchBar.text?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        queryBooks(bookTitle: bookTitle!)
        searchBar.resignFirstResponder()
    }

    func queryBooks(bookTitle: String) {
        let stringURL = "https://www.googleapis.com/books/v1/volumes?q=\(bookTitle)"
        guard let url = URL(string: stringURL) else {
            print("Problem with URL")
            return
        }
        let urlRequest = URLRequest(url: url as URL)
        let urlSession = URLSession.shared
        let queryTask = urlSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let jsonData = data else {
                print("No Information could be Found:")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]

                guard let tableItems = json["items"] as? [[String: AnyObject]] else {
                    self?.booksFound = [[String: Any]]()
                    return
                }

                self?.booksFound = tableItems
                DispatchQueue.main.async {
                    self!.tableView.reloadData()
                }
            } catch {
                print("Error with JSON: ")
            }
        }
        queryTask.resume()
    }
}

