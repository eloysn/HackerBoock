//
//  Library.swift
//  HackerBooks
//
//  Created by Eloy Sanz Navarro on 10/12/15.
//  Copyright © 2015 FratelliApps. All rights reserved.
//

import UIKit



class Library  {
    
    
    var tags :[String] = []
    var model :[Boock] = []
    var tagBook : [String:[Boock]] = [:]
    
    init(){
        
        tags = [String]()
        model = [Boock] ()
        tagBook = [String:[Boock]] ()
        
        do{
            
           let library = try modelData()
            tags = library.1
            model = library.0
            
            
        }catch{
            
            fatalError("No se pudo decodifiar el JSON")
            
        }
        
      tagBook = boockForTags(model)
    }
    
    
    func  modelData ( )throws ->([Boock], [String]) {
        
        
        
        if let dataJason = NSData(contentsOfURL: Utils().fileInDocumentsDirectory(Settting.datajson.rawValue)),
            dataModel =  try NSJSONSerialization.JSONObjectWithData(dataJason, options: .AllowFragments) as? [[String:AnyObject]] {
        
             model = try DecodeJason().decodeBook(dataModel)
             tags = arrayTags(forLibrary: model)
             
                
                
        }
       
       
        return (model ,tags)
    }
    
    func arrayTags ( forLibrary library: [Boock]) -> [String]{
        
        var result : [String] = [" Favoritos"]
        
        for tag in library {
            
            let tagString = tag.tags
            result.appendContentsOf(tagString)
        }
        
        let tags = Utils().removeDuplicates(result).sort()
        
        
        print(tags.count)
        return tags
        
        
    }
     func boockForTags ( boocks: [Boock])-> [String:[Boock]] {
        
        
        var TagsBooks : [String:[Boock]] = [" Favoritos":[]]
        
        
        for book in boocks{
            for tag in book.tags{
                //procesamos todos los tags de cada libro
                if let _ = TagsBooks[tag]    {
                    
                    TagsBooks[tag]?.append(book)
                }else{
                    
                    TagsBooks[tag] = [Boock]()
                    TagsBooks[tag]?.append(book)
                }
                
                
            }
        }
        
        
        print(TagsBooks.count)
        return TagsBooks
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
}
