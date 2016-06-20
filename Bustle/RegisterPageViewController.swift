//
//  RegisterPageViewController.swift
//  Bustle
//
//  Created by student on 6/19/16.
//  Copyright © 2016 student. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var InterestsTextField: UITextView!
        @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RepeatPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        InterestsTextField.delegate = self
        InterestsTextField.textColor = UIColor.darkGrayColor()

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
        
        //Check if interests contains valid entries
        if((userInterests.isEmpty || userInterests.containsString("Enter your interests here separated by a comma.  Please be as specific as possible (instead of 'sports' enter 'tennis, football, and swimming')")) && ((userEmail?.isEmpty == false) && (userPassword?.isEmpty == false) && (userRepeatPassword?.isEmpty == false)))
        {
            displayMyAlertMessage("Please type valid interests")
        }
        
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty)
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
        
        // Store datal
        
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


