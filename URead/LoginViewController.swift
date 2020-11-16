//
//  LoginViewController.swift
//  URead
//
//  Created by Cindy on 11/13/20.
//

import UIKit
import FBSDKLoginKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
//        let loginButton = FBLoginButton()
//                loginButton.center = view.center
//                view.addSubview(loginButton)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        let username = tfUsername.text!
        let password = tfPassword.text!
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    @IBAction func onSignup(_ sender: Any) {
        var user = PFUser()
        user.username = tfUsername.text
        user.password = tfPassword.text
        
        user.signUpInBackground { (success, error) in
            if success{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
                
            }
           
        }
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true{
//            self.performSegue(withIdentifier: "loginToHome", sender: self)
//        }
//
//    }

    @IBAction func wcLogin(_ sender: Any) {
    }
    
    @IBAction func fbLogin(_ sender: Any) {
        
    }
    
    @IBAction func gmailLogin(_ sender: Any) {
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
