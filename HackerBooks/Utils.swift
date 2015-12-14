//
//  Utils.swift
//  HackerBooks
//
//  Created by Eloy Sanz Navarro on 9/12/15.
//  Copyright © 2015 FratelliApps. All rights reserved.
//

import UIKit

var countImage = 0

class Utils {
    
    
    
    //Obtenemos el directorio document de la app
     func getDocumentsURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL
    }
    
    
    //Ruta a documents concatenado con el archivo
       func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        return fileURL.path!
        
    }
    func fileInDocumentsDirectory(filename: String) -> NSURL {
        
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        return fileURL
        
    }
    func getCacheURL() -> NSURL {
        let cachesURL = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]
        return cachesURL
    }
    
    
    //Obtenemos el directorio cache de la app
    func UrlCache(filename: String) -> NSURL{
        
        let fileURL = getCacheURL().URLByAppendingPathComponent(filename)
        return fileURL
    }
    func fileInDocumentsCache(filename: String) -> String{
        
        let fileURL = getCacheURL().URLByAppendingPathComponent(filename)
        return fileURL.path!
    }

    func downloadImagesSave (urlImage: NSURL, index: Int, callBack: () -> Void ){
         let sesion = NSURLSession.sharedSession()
         let task = sesion.dataTaskWithURL(urlImage) { (data, response, error ) -> Void in
            
            
             data!.writeToFile(Utils().fileInDocumentsCache("imagen\(index)"), atomically: true)
            callBack()
                        
            
        }
        task.resume()
        
    }
    func downloadPdfSave (urlPdf: NSURL, index: Int,  callBack: (NSData) -> Void ){
        
        let sesion = NSURLSession.sharedSession()
        let task = sesion.dataTaskWithURL(urlPdf) { (data , response, error ) -> Void in
            
            
            data!.writeToFile(Utils().fileInDocumentsCache("pdf\(index)"), atomically: true)
            callBack(data!)
        }
        
        task.resume()
        
        
        
        
    }
    
    
    
    
    
    
   
    
}



