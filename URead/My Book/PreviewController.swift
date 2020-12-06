//
//  PreviewController.swift
//  URead
//
//  Created by Cindy on 12/6/20.
//

import UIKit

class PreviewController: UIViewController {
    @IBOutlet weak var previewISBN: UILabel!
    @IBOutlet weak var pvTitle: UILabel!
    @IBOutlet weak var pvAuthor: UILabel!
    @IBOutlet weak var pvSummary: UILabel!
    @IBOutlet weak var pvImage: UIImageView!
    @IBOutlet weak var addToShelf: UIButton!
    
    
    var bookOut = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var isbn = ScannedISBN.isbn
        queryBook(bookISBN: isbn)
        // Do any additional setup after loading the view.
    }
    
    func queryBook(bookISBN: String) {
        self.previewISBN.text = ScannedISBN.isbn
        let stringURL = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(bookISBN)"
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

                if json["totalItems"] as! Int == 0 {
                    print("Sorry, this book is not in our database yet.")
                } else {
                    //setting up the view
                    print(json["items"])
                    self!.bookOut = json["items"] as! [[String: Any]]
                    
                    //
                    
                    if let base = self?.bookOut[0]["volumeInfo"] as? [String: Any] {
                        DispatchQueue.main.async {

                            // Do all your UI stuff here
                            let id = self?.bookOut[0]["id"] as! String
                            let title = base["title"] as! String
                            let authors = base["authors"] as? [String]
                    
                            let overview = base["description"] ?? "No offical description yet, view more detail on Google"
                            let imagesfirst = "http://books.google.com/books/content?id="
                            let imagelast = "&printsec=frontcover&img=1"
                            let imageUrl = URL(string: imagesfirst + id + imagelast)!
                            print(title, authors, overview)
                
                            self!.pvImage.af_setImage(withURL: imageUrl)
                            self!.pvTitle.text = title
                        
                            if authors == nil{
                                self!.pvAuthor.text = "Unknown"
                            } else {
                                self!.pvAuthor.text = authors?.joined(separator:", ")
                            }
                                self!.pvSummary.text = overview as? String
                        
                        }

                        }
                        
                }
                return

            } catch {
                print("Error with JSON: ")
                
                
            }
        }
        queryTask.resume()
    
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
