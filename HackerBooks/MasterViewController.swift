//
//  MasterViewController.swift
//  HackerBooks
//
//  Created by Eloy Sanz Navarro on 6/12/15.
//  Copyright © 2015 FratelliApps. All rights reserved.
//

import UIKit
import Foundation

class MasterViewController: UITableViewController , DelegateProtocol{

    
    
    let userDefault = NSUserDefaults.standardUserDefaults()
    var detailViewController: DetailViewController? = nil
    var library = Library()
    
    var isfavorite = 0
    
    
    
    
    //MARK: -Protocols
    
    func update(boock: Boock) {
       //Tenemos que actualizar toda la library
     
        checkIsBookFavorites(library.model)
        self.tableView.reloadData()
        
    }
    
    
    
    
    override func viewDidLoad()  {
        
        super.viewDidLoad()
        self.title = "HackerBoocks"
        //iniciamos la Library
        library = Library.init()
        checkIsBookFavorites(library.model)
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
            
        }
        if let lastSection = userDefault.stringForKey(Settting.lastSection.rawValue){
            
            let lastRow = userDefault.integerForKey(Settting.lastRow.rawValue)
            
            
            if let lastBook = library.tagBook[lastSection]{
             self.detailViewController?.boock = lastBook[lastRow]
           
            
            }
            
        }else{
            
            self.detailViewController?.boock = library.model[0]
            
        }
        
        
       
        
    
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkIsBookFavorites (books:[Boock])  {
        
        var resultBoock = [Boock] ()
        for book in books {
            
            if book.isFavorite {
                resultBoock.append(book)
                
            }
        }
        if resultBoock.count > 0 {
            
            if !library.tags.contains(" Favoritos"){
                library.tags.append(" Favoritos")
                library.tags.sortInPlace()
                library.tagBook[" Favoritos"] = resultBoock
                
                
            }else {
                library.tagBook[" Favoritos"] = resultBoock
                
            }
            
            
        }else{
            if library.tags.contains(" Favoritos"){
                
                library.tagBook.removeValueForKey(" Favoritos")
                library.tags.removeFirst()
                userDefault.setInteger(0, forKey: Settting.lastRow.rawValue)
                userDefault.setObject("Access Controls", forKey: Settting.lastSection.rawValue)
                
            }
            
            
        }
            
        
           
        
    }
    



    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let section = library.tags[indexPath.section]
                let book = library.tagBook[section]
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                controller.delegate = self
                controller.boock = book?[indexPath.row]

                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

     //MARK: - Table View
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        return library.tags[section]
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return library.tags.count 
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let tagInSection = library.tags[section]
        
        
        return (library.tagBook[tagInSection]?.count)!
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tagInSection = library.tags[indexPath.section]
        let book = library.tagBook[tagInSection]
        let nameIma = book?[indexPath.row].ima_url.lastPathComponent

        
       let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
       let checkValidation = NSFileManager.defaultManager()
       
       
        
        if (checkValidation.fileExistsAtPath(Utils().fileInDocumentsCache(nameIma!)))
        {
            //FILE AVAILABLE
             let urlIma = Utils().UrlCache(nameIma!)
            if let dataIma = NSData(contentsOfURL: urlIma){
                cell.imageView?.image = UIImage(data: dataIma)
            }
        }
        else
        {
            //FILE NOT AVAILABLE
             cell.imageView?.image = UIImage(named: "ebook.png")
        }

          cell.textLabel!.text = book?[indexPath.row].title
          cell.detailTextLabel!.text  = book?[indexPath.row].authors.joinWithSeparator(",")
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = library.tags[indexPath.section]
        let row = indexPath.row
            
       // print(library.model.filter({$0.tags.contains("Algorithms")}).count)
        
        userDefault.setInteger(row, forKey: Settting.lastRow.rawValue)
        userDefault.setObject(section, forKey: Settting.lastSection.rawValue)
        

    }
    
    

}

