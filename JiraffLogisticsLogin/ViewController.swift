//
//  ViewController.swift
//  JiraffLogisticsLogin
//
//  Created by Михаил Поспелов on 08.12.14.
//  Copyright (c) 2014 Михаил Поспелов. All rights reserved.
//

import Alamofire
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldLogin: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!

    @IBOutlet weak var labelErrorHandler: UILabel!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    @IBAction func outputPlist(sender: AnyObject) {
        var google_api_key = Config.get("google_api_key")
        labelErrorHandler.text = "GKey: \(google_api_key)\n"
    }
    
    @IBAction func verifyCredentials(sender: AnyObject) {
        let params = ["login": textFieldLogin.text, "password": textFieldPassword.text]
        Alamofire.request(.GET, "http://localhost:4567/users/sign_in", parameters: params)
                 .validate()
                 .responseJSON{(_, _, json_response, error) in
                    self.stopSpinner()
                    let json = json_response as Dictionary<String, String>
                    if error == nil{
                        self.labelErrorHandler.text = json["success"]
                    }else{
                        self.labelErrorHandler.text = json["error"]
                    }

                 }

        startSpinner()
        textFieldLogin.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopSpinner()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startSpinner(){
        activitySpinner.hidden = false
        activitySpinner.startAnimating()
    }
    
    func stopSpinner(){
        activitySpinner.hidden = true
        activitySpinner.stopAnimating()
    }

}

