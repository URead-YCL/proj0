//
//  HomeDetailViewController.swift
//  URead
//
//  Created by Cindy on 11/16/20.
//

import UIKit
import AlamofireImage

class HomeDetailViewController: UIViewController {
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var pageNumber: UILabel!
    @IBOutlet weak var peoplerec: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var btFinished: UIButton!
    @IBOutlet weak var btAdd: UIButton!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var closeBt: UIBarButtonItem!
    
    
//    var booksFound: [[String:Any]]!
    var book: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//
        var base = book["volumeInfo"] as? [String: Any]
//        let id = book["id"] as! String
//        let title = base?["title"] as! String
//        let authors = base["authors"] as! [String]
//
//            let overview = base["description"] ?? "No offical description yet, view more detail on Google"
//            let imagesfirst = "http://books.google.com/books/content?id="
//            let imagelast = "&printsec=frontcover&img=1"
//            let imageUrl = URL(string: imagesfirst + id + imagelast)!
//    print(imageUrl)
//
//            let identifier = base["industryIdentifiers"] as! [[String:String]]
//            let isbn13 = identifier[0]["identifier"]!
//
//            cell.ivBookpic.af_setImage(withURL: imageUrl)
//            cell.tvTitle.text = title
//
        
//        let book = self.booksFound[indexPath.row]
//        if let base = self.booksFound[indexPath.row]["volumeInfo"] as? [String: Any]
        
   
        bookTitle.sizeToFit()
        summary.sizeToFit()
        bookAuthor.sizeToFit()
        
        bookTitle.text = base!["title"] as! String
        
       
        if base!["description"]  == nil {
            summary.text = "Sorry! There is no description for this book yet."
        } else {
            summary.text =  base!["description"] as! String
        }
        
        var author: [String]
        if base!["authors"] == nil {
            author = ["Unknow"]
        } else {
            author =  base!["authors"] as! [String]
        }
        bookAuthor.text = "Authors: " + author.joined(separator:", ")
        
        
        if base!["pageCount"] == nil {
            pageNumber.text = "Unknown Page Number"
        } else {
            var num = base!["pageCount"] as! Int
            pageNumber.text = "Page Count: \(num)" as! String

        if base!["ratingsCount"] == nil {
            peoplerec.text = "Unknown # of People Recommended"
        } else {
            var num = base!["ratingsCount"] as! Int
            peoplerec.text = "# Recommended: \(num)" as! String
        }

            
    
        if base!["averageRating"] == nil {
            rating.text = "Unknown Rating"
        } else {
            let num = base!["averageRating"]!
            rating.text = "Rating: \(num)" as! String
            
        }
          


//        @IBOutlet weak var btFinished: UIButton!
//        @IBOutlet weak var btAdd: UIButton!
        
    
        let imagesfirst = "http://books.google.com/books/content?id="
        let imagelast = "&printsec=frontcover&img=1"
        
        let posterId = book["id"] as! String
        let posterURL = URL(string: imagesfirst + posterId + imagelast)
        
        picture.af_setImage(withURL: posterURL!)
        
//        let backdrop = movie["backdrop_path"] as! String
//        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdrop)
//        backdropView.af_setImage(withURL: backdropURL!)

        // Do any additional setup after loading the view.
    }

}
    @IBAction func dismissPage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
