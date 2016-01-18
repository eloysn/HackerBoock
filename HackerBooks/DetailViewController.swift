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
    
    //Propertis
    var delegate :DelegateProtocol?
    var boock : Boock? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    

    
    
    @IBAction func selectFavorite(sender: AnyObject) {
        
        if !swictchFavorito.on {
            
            userDefault.setBool(false, forKey: "bookIsFavorite\(boock!.title)")
            boock?.isFavorite = false
            delegate?.update(boock!)
            
        }else{
            userDefault.setBool(true, forKey: "bookIsFavorite\(boock!.title)")
            boock?.isFavorite = true
            delegate?.update(boock!)
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
                if let nameIma = boock?.ima_url.lastPathComponent {
                    
                    if (checkValidation.fileExistsAtPath(Utils().fileInDocumentsCache(nameIma)))
                    {
                        let urlIma = Utils().UrlCache(nameIma)
                        if let dataIma = NSData(contentsOfURL: urlIma){
                            imageBoock.image = UIImage(data: dataIma)
                        }
                    }
  
                    
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
            
        
        }
        
    
    }
  
    
    
    
    
    
    
    
    
}


