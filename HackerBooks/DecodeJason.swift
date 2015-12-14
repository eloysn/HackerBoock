//
//  DecodeJason.swift
//  HackerBooks
//
//  Created by Eloy Sanz Navarro on 9/12/15.
//  Copyright © 2015 FratelliApps. All rights reserved.
//

import UIKit
import Swift


class DecodeJason {
    
    
    
    func decodeBook (data: [[String:AnyObject]]) throws -> [Boock] {
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        var count = 0
        var boock = [Boock]()
        
    
        for dict in data {
            
            guard let title = dict["title"] as? String else {
                
                throw errors.errorForResource
            }
            guard let author = dict["authors"] as? String else {
                
                throw errors.errorForResource
                
            }
           
            let authors = author.componentsSeparatedByString(",")
            
            guard let tag = dict["tags"] as? String  else {
                
                throw errors.errorForResource
            }
            let tags = tag.componentsSeparatedByString(",")
            
            guard let stringpdf = dict["pdf_url"] as? String ,pdf = NSURL(string: stringpdf) else {
                
                throw errors.errorForResource
            }
            guard let url = dict["image_url"] as? String, ima_url = NSURL(string: url) else {
                
                 throw errors.errorForResource
            }
            
            
            var isFavorite : Bool = false
            
            if userDefault.objectForKey("boockIsFavorite\(count)") as? Bool == true {
                
                 isFavorite = true
            }else{
                
                 isFavorite = false
            }
            
            

            
            let newBook = Boock(title: title, authors: authors, tags: tags, pdf: pdf, ima_url: ima_url, isFavorite: isFavorite )
            
            boock.append(newBook)
            count += 1
        }
        
        
        
        
       return boock
    }


    




}