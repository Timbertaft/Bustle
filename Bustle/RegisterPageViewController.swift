//
//  RegisterPageViewController.swift
//  Bustle
//
//  Created by student on 6/19/16.
//  Copyright © 2016 student. All rights reserved.
//

import UIKit
import Firebase

class RegisterPageViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var AddressTextField: UITextField!
    @IBOutlet weak var InterestsTextField: UITextView!
        @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RepeatPasswordTextField: UITextField!
    var ref : FIRDatabaseReference?
    
    
    //var ref : FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        InterestsTextField.delegate = self
        InterestsTextField.textColor = UIColor.darkGrayColor()
        self.ref = FIRDatabase.database().reference()
        

        // Do any additional setup after loading the view.
        
    }

        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        //Clear Interest text on tap
    func textViewDidBeginEditing(textView: UITextView) {
        InterestsTextField.text = ""
        InterestsTextField.textColor = UIColor.blackColor()
    }

    @IBAction func preregisterButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func registerButtonTapped(sender: AnyObject) {
        let userEmail = userEmailTextField.text;
        let userPassword = PasswordTextField.text;
        let userRepeatPassword = RepeatPasswordTextField.text;
        let userInterests = InterestsTextField.text;
        let userAddress = AddressTextField.text;
        let userUsername = UsernameTextField.text;
        var users = ["Username" : UsernameTextField.text, "Email" : userEmailTextField.text, "Address" : AddressTextField.text, "Interests" : InterestsTextField.text, "Password" : PasswordTextField.text]
        var userRef = ref!.childByAppendingPath("users").childByAutoId()
        userRef.setValue(users)
        
        
        
        
        //Check if interests contains valid entries
        if((userInterests.isEmpty || userInterests.containsString("Enter your interests here separated by a comma.  Please be as specific as possible (instead of 'sports' enter 'tennis, football, and swimming')")) && ((userEmail?.isEmpty == false) && (userPassword?.isEmpty == false) && (userRepeatPassword?.isEmpty == false)))
        {
            displayMyAlertMessage("Please type valid interests")
        }
        
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty || userAddress!.isEmpty || userUsername!.isEmpty)
        {
            // Display alert message
            
            displayMyAlertMessage("All fields are required");
            
            return;
        }
        
        
        if((userEmail?.rangeOfString("@") != nil) && (userEmail?.rangeOfString(".com") != nil) || (userEmail?.rangeOfString(".org") != nil) || (userEmail?.rangeOfString(".edu") != nil) || (userEmail?.rangeOfString(".net") != nil) || (userEmail?.rangeOfString(".gov") != nil))
        {
        
        }
        else {
            displayMyAlertMessage("Valid Email required")
            
            return;
        }
 

        //Check if passwords match
        if(userPassword != userRepeatPassword)
        {
            // Display an alert message
            displayMyAlertMessage("Passwords do not match");
            return;
        }
        //Authenticate User with Firebase and check for duplicates
        //This has a bug.
        FIRAuth.auth()?.createUserWithEmail(userEmail!, password: userPassword!, completion: { user, error in
            if error != nil {
                self.displayMyAlertMessage("Email Already Exists.  Please Try Again.")
                self.login()
                return;
                
                
            } else {
                userRef.setValue(users)
                self.login()
                
            }
            
        })

        
        // Store data
        
        
        
        //Display alert message with confirmation.
        var myAlert = UIAlertController(title: "Alert", message: "Registration is complete!", preferredStyle: UIAlertControllerStyle.Alert);
    
    
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default)
    {
        action in
        self.dismissViewControllerAnimated(true, completion: nil);
        
        }
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil);
        
    }
    func login() {
        
        FIRAuth.auth()?.signInWithEmail(userEmailTextField.text!, password: PasswordTextField.text!, completion: { user, error in
            if error != nil {
                self.displayMyAlertMessage("Wrong Information.  Try Again.")
            }
            
        })
        
    }


    func displayMyAlertMessage(userMessage:String)
    {
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


