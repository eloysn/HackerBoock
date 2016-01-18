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
        
        let checkValidation = NSFileManager.defaultManager()
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
            //Procesamos los Tag en un array sin espacos en blanco y primera en mayusculas
            var tags = [String]()
            let tagsArr = tag.componentsSeparatedByString(",")
            for tag in tagsArr {
                let newTag = tag.capitalizedString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                tags.append(newTag)
            }
            
            
            
            guard let strPdf = dict["pdf_url"] as? String, pdfUrl = NSURL(string: strPdf) else {
                
                throw errors.errorForResource
            }
            
            
            
            
            guard let strIma = dict["image_url"] as? String, imaUrl = NSURL(string: strIma), lastCompUrlIma = imaUrl.lastPathComponent else {
                                     throw errors.errorForResource
            }
            //Coprobamos si tenemos las imagenes
            if (!checkValidation.fileExistsAtPath(Utils().fileInDocumentsCache(lastCompUrlIma))){
                print("no esta le imagen")
                Utils.imageDownloading(imaUrl)
            }
            
            
            var isFavorite : Bool = false
            
            if userDefault.objectForKey("bookIsFavorite\(title)") as? Bool == true {
                
                 isFavorite = true
            }else{
                    
                 isFavorite = false
                
            }
            
            
            
            let newBook = Boock(title: title, authors: authors, tags: tags, pdf: pdfUrl, ima_url: imaUrl, isFavorite: isFavorite )
            
            boock.append(newBook)
            count += 1
        }
        
        
        
        
       return boock
    }


    




}