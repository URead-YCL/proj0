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
    
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookTitle.text = movie["title"] as? String
        summary.text = movie["overview"] as? String
        bookTitle.sizeToFit()
        summary.sizeToFit()
        
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        
        let poster = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + poster)
        
        picture.af_setImage(withURL: posterURL!)
        
//        let backdrop = movie["backdrop_path"] as! String
//        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdrop)
//        backdropView.af_setImage(withURL: backdropURL!)

        // Do any additional setup after loading the view.
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
