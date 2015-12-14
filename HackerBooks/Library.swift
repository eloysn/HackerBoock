//
//  Library.swift
//  HackerBooks
//
//  Created by Eloy Sanz Navarro on 10/12/15.
//  Copyright © 2015 FratelliApps. All rights reserved.
//

import UIKit



class Library {
    
    
    
    var model = [Boock]()
    
    func  modelData ( )throws ->[Boock] {
        
        
        
        if let dataJason = NSData(contentsOfURL: Utils().fileInDocumentsDirectory(Settting.datajson.rawValue)),
            dataModel =  try NSJSONSerialization.JSONObjectWithData(dataJason, options: .AllowFragments) as? [[String:AnyObject]] {
        
             model = try DecodeJason().decodeBook(dataModel)
        }
       
        
        return model
    }
    
    
}
