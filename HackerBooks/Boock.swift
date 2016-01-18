//
//  Boock.swift
//  HackerBooks
//
//  Created by Eloy Sanz Navarro on 7/12/15.
//  Copyright © 2015 FratelliApps. All rights reserved.
//

import UIKit


class Boock : CustomDebugStringConvertible {
    
    
    let title : String
    let authors : [String]
    let tags : [String] 
    let pdf : NSURL
    let ima_url : NSURL
    var isFavorite : Bool
    
    
    var debugDescription: String {
    
        return "\(self.dynamicType) \(title)"
    }
    
    init (title: String, authors: [String], tags: [String], pdf: NSURL, ima_url: NSURL,isFavorite: Bool){
        
        self.title = title
        self.authors = authors
        self.tags = tags
        self.pdf = pdf
        self.ima_url = ima_url
        self.isFavorite = isFavorite
        
    }
    

    
    
    
    
    
}
