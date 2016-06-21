//
//  ViewController.swift
//  Bustle
//
//  Created by student on 6/18/16.
//  Copyright © 2016 student. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
var SecondTime = 0
    override func viewDidAppear(animated: Bool) {
            SecondTime = SecondTime + 1;
        if(SecondTime <= 1)
        {
          self.performSegueWithIdentifier("LoginView", sender: self)
        } else {
        
        }
    }

    
}
//Adds functionality to each ViewController that calls this function to click off the keyboard for text entry.
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        resignFirstResponder()
    }
}



