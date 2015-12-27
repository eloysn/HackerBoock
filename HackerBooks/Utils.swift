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
    //Descarga de archivos
    
    static func imageDownloading (url:NSURL) {
        
        let sesion = NSURLSession.sharedSession()
        if let localUrlImage = url.lastPathComponent{
            let task = sesion.dataTaskWithURL(url) { (data, response, error ) -> Void in
                
                
                data!.writeToFile(Utils().fileInDocumentsCache(localUrlImage), atomically: true)
                
            }
            task.resume()
            
        }
        
        
        
    }
    static func pdfDowloading (url: NSURL, callBack: (data: NSData)->Void) {
        
        let sesion = NSURLSession.sharedSession()
        if let localUrlPdf = url.lastPathComponent{
            let task = sesion.dataTaskWithURL(url) { (data, response, error ) -> Void in
                
                
                data!.writeToFile(Utils().fileInDocumentsCache(localUrlPdf), atomically: true)
                callBack(data: data!)
            }
            task.resume()
            
        }
        
    }
    
    
    //func eliminar duplicados
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
    }
    
    
    
    
   
    
}



