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
    
    var user = PFUser.current()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()
        idNum.text = user?.username
        let imageFile = user?["profilePic"] as! PFFileObject
        if imageFile != nil {
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            userImageView.af_setImage(withURL: url)
        }
            
        // Do any additional setup after loading the view.
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
       
        let data = image.jpegData(compressionQuality: 0.5)!
        let file = PFFileObject(data: data, contentType: "image/jpeg")
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
//        self.user?.setObject(file, forKey: "profile_pic")
//        user?.saveInBackground(block: { (success, error) in
//            if success{
//                self.user?.setObject(file, forKey: "profile_pic")
//            } else {
//                print("error saving profile_pic")
//            }
//        })
 
        
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
