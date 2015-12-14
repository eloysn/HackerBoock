//
//  WebViewPdfController.swift
//  HackerBooks
//
//  Created by Eloy Sanz Navarro on 12/12/15.
//  Copyright © 2015 FratelliApps. All rights reserved.
//

import UIKit

class WebViewPdfController: UIViewController {

    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var pdfWebView: UIWebView!
    var index :Int = 0
    var boock : Boock? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    override func viewDidLoad() {
        
        
        activity.startAnimating()
        let checkValidation = NSFileManager.defaultManager()
        let url = Utils().UrlCache("pdf\(index)")
        let data = NSData(contentsOfURL: url)
        
        if (checkValidation.fileExistsAtPath(Utils().fileInDocumentsCache("pdf\(index)")))
        {
            //FILE AVAILABLE
            
            pdfWebView.loadData(data!, MIMEType: "application/pdf", textEncodingName: "utf-8", baseURL: (boock?.pdf)!)
            self.activity.stopAnimating()
        }
        else
        {
            //FILE NOT AVAILABLE
            Utils().downloadPdfSave((boock?.pdf)!, index: index,  callBack: { (dat) -> Void in
                
                
                self.pdfWebView.loadData(dat, MIMEType: "application/pdf", textEncodingName: "utf-8", baseURL: (self.boock?.pdf)!)
                self.activity.stopAnimating()
            })
            
        }
        
        
        
        
        
        
        
    }
    
    func configureView() {
    
        
        
    
    }
    

        



}
