//
//  DetailViewController.swift
//  HackerBooks
//
//  Created by Eloy Sanz Navarro on 6/12/15.
//  Copyright © 2015 FratelliApps. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var labelAuthors: UILabel!
    @IBOutlet weak var labelTags: UILabel!
    
    @IBOutlet weak var imageBoock: UIImageView!
   
    @IBOutlet weak var swictchFavorito: UISwitch!
    
    let checkValidation = NSFileManager.defaultManager()
    
    let userDefault = NSUserDefaults.standardUserDefaults()
    var delegate :DelegateProtocol?
    var IndexPath: Int = 0
    var boock : Boock? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    var detailItem: AnyObject? {
        
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    
    
    @IBAction func selectFavorite(sender: AnyObject) {
        
        if !swictchFavorito.on {
            
            userDefault.setBool(false, forKey: "boockIsFavorite\(IndexPath)")
            boock?.isFavorite = false
            delegate?.update(boock!, indexPath: IndexPath)
            
        }else{
            
            boock?.isFavorite = true
            userDefault.setBool(true, forKey: "boockIsFavorite\(IndexPath)")
            delegate?.update(boock!, indexPath: IndexPath)
        }
    }
    
    
    
    func configureView() {
        
      
        
        self.title = boock?.title
        // Update the user interface for the detail item.
        
            if let labelAuthor = self.labelAuthors {
                self.title = boock?.title
                swictchFavorito.on = (boock?.isFavorite)!
                labelAuthor.text = boock?.authors.joinWithSeparator(",")
                labelTags.text = boock?.tags.joinWithSeparator(",")
                let url = Utils().UrlCache("imagen\(IndexPath)")
                
                if (checkValidation.fileExistsAtPath(Utils().fileInDocumentsCache("imagen\(IndexPath)")))
                {
                    imageBoock.image = UIImage(data: NSData(contentsOfURL: url)!)
                }
                
                
            }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: -Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showPdf" {
            
            let controller = segue.destinationViewController as? WebViewPdfController
            controller!.boock = boock
            controller!.index = IndexPath
        
        }
        
    
    }
  
    
    
    
    
    
    
    
    
}


