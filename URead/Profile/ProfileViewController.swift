//
//  ProfileViewController.swift
//  URead
//
//  Created by Cindy on 11/28/20.
//

import UIKit
import Parse



class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var idNum: UILabel!
    @IBOutlet weak var bookNum: UILabel!
    @IBOutlet weak var noteNum: UILabel!
    
    @IBOutlet weak var logout: UIButton!
    
    @IBOutlet weak var top1: UILabel!
    
    @IBOutlet weak var top2: UILabel!
    
    @IBOutlet weak var top3: UILabel!
    
    var user = PFUser.current()
    var bookcount:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
    }
    override func viewWillAppear(_ animated: Bool) {
        let user = PFUser.current()
        idNum.text = user?.username
        
        let query = PFQuery(className: "Books")
        query.whereKey("UserID", equalTo: user)
        
        query.findObjectsInBackground { (books, error) in
            if books == Optional([]) {
                self.bookNum.text = "0"
//                self.bookcount = "0"
            } else if (books != nil) {
                var helper = books!.count
                self.bookNum.text = "\(helper)"
                print(self.bookNum.text)
            }
            
        }
        let query1 = PFQuery(className: "Notes")
        query1.whereKey("UserID", equalTo: user)
        
        query1.findObjectsInBackground { (notes, error) in
            if notes == Optional([]) {
                self.noteNum.text = "0"
//                self.bookcount = "0"
            } else if (notes != nil) {
                var helper = notes!.count
                self.noteNum.text = "\(helper)"
                print(self.noteNum.text)
            }
            
        }
        
        let query2 = PFQuery(className: "Books")
        query2.whereKey("UserID", equalTo: user)
        query2.addDescendingOrder("TimeStamp")
        query2.findObjectsInBackground { (books, error) in
            if books == Optional([]) {
                self.top1.text = "N/A"
                self.top2.text = "N/A"
                self.top3.text = "N/A"
            } else if (books!.count == 1) {
                var helper = books![0] as! PFObject
                self.top1.text = helper["title"] as! String
                self.top2.text = "N/A"
                self.top3.text = "N/A"
            } else if (books!.count == 2) {
                var helper = books![0] as! PFObject
                var helper1 = books![1] as! PFObject
                self.top1.text = helper["title"] as! String
                self.top2.text = helper1["title"] as! String
                self.top3.text = "N/A"
            } else {
                var helper = books![0] as! PFObject
                var helper1 = books![1] as! PFObject
                var helper2 = books![2] as! PFObject
                self.top1.text = helper["title"] as! String
                self.top2.text = helper1["title"] as! String
                self.top3.text = helper2["title"] as! String
            }
            
            
        }
        
        if user?["profilePic"] != nil {
            let imageFile = user?["profilePic"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            userImageView.af_setImage(withURL: url)
        }
    }
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType)-> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        
        return imagePicker
    }
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default) {_ in
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) {_ in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(photoLibraryAction)
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as! UIImage
        userImageView.image = image
       
        print(image)
        let data = image.pngData()!
        let file = PFFileObject(data: data, contentType: "png")
//        let imagedata = image.pngData()
//        let file = PFFileObject(data: imagedata!)
        
        PFUser.current()?["profilePic"] = file
        PFUser.current()?.saveInBackground(block: { (success, error) in
            if success {
                print("profile pic saved")
            } else {
                print("error saving profile_pic")
            }
        })
        dismiss(animated: true, completion: nil)
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
