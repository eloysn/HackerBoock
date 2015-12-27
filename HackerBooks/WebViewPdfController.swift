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
        if let urlPdf = boock?.pdf  {
        
        
      if (checkValidation.fileExistsAtPath(Utils().fileInDocumentsCache(urlPdf.lastPathComponent!)))
        {
            //FILE AVAILABLE
            let localUrlPdf = Utils().UrlCache(urlPdf.lastPathComponent!)
            let data = NSData(contentsOfURL: localUrlPdf)
            pdfWebView.loadData(data!, MIMEType: "application/pdf", textEncodingName: "utf-8", baseURL: urlPdf)
            self.activity.stopAnimating()
        }
        else
        {
            //FILE NOT AVAILABLE
           
          Utils.pdfDowloading(urlPdf, callBack: { (data) -> Void in
            self.pdfWebView.loadData(data, MIMEType: "application/pdf", textEncodingName: "utf-8", baseURL: urlPdf)
            self.activity.stopAnimating()
          })
           
            
        }
        
        }
        
        
        
        
        
    }
    
    func configureView() {
    
        
        
    
    }
    

        



}
