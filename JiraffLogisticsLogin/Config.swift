//
//  Config.swift
//  JiraffLogisticsLogin
//
//  Created by Михаил Поспелов on 06.01.15.
//  Copyright (c) 2015 Михаил Поспелов. All rights reserved.
//

import Foundation

class Config{

    private struct Store {
        static let credentials_path = NSBundle.mainBundle().pathForResource("credentials", ofType: "plist")!
        static let credentials: NSDictionary = NSDictionary(contentsOfFile: credentials_path)!
    }
    
    class func get(key: String)-> String{
        return Store.credentials.valueForKey(key) as String
    }
}