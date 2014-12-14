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
        
        let path = NSBundle.mainBundle().pathForResource("credentials", ofType: "plist")!
        var myDict: NSMutableDictionary = NSMutableDictionary(contentsOfFile: path)!
        var login: String = myDict.valueForKey("login") as String,
            password: String =  myDict.valueForKey("password") as String
        myDict.setValue((login + password) as NSString, forKey: "login" as NSString)
        myDict.writeToFile(path, atomically: true)
        labelErrorHandler.text = "Логин: \(login) Пароль: \(password)\n"
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

