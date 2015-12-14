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

    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var imaBoock: UIImageView!
    let userDefault = NSUserDefaults.standardUserDefaults()
    var detailViewController: DetailViewController? = nil
    //var objects = [AnyObject]()
    var arrBoock = [Boock]()
    
    
    
    
    //MARK: -Protocols
    
    func update(boock: Boock, indexPath: Int) {
        
        arrBoock[indexPath] = boock
        self.tableView.reloadData() 
        
    }
    
    
    
    
    override func viewDidLoad()  {
        
        super.viewDidLoad()
        self.title = "HackerBoocks"
        
        
        do{
            arrBoock =  try Library().modelData()
        }catch{
            print("Esto puede salir mal")
            fatalError()

        }
        
        let lastBoock = userDefault.objectForKey("lastBoockSelet") as? Int
        
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
            
            if (lastBoock != nil) {
                self.detailViewController?.boock = arrBoock[lastBoock!]
                self.detailViewController?.IndexPath = lastBoock!
            }else{
                self.detailViewController?.boock = arrBoock[0]
                self.detailViewController?.IndexPath = 0
            }
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
    
    



    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                userDefault.setInteger(indexPath.row, forKey: "lastBoockSelet")
                controller.delegate = self
                controller.detailItem = arrBoock[indexPath.row]
                controller.boock = arrBoock[indexPath.row]
                controller.IndexPath = indexPath.row
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return objects.count
        
        return arrBoock.count
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let checkValidation = NSFileManager.defaultManager()
        let url = Utils().UrlCache("imagen\(indexPath.row)")
        
        if (checkValidation.fileExistsAtPath(Utils().fileInDocumentsCache("imagen\(indexPath.row)")))
        {
            //FILE AVAILABLE
        
            cell.imageView?.image = UIImage(data: NSData(contentsOfURL: url)!)
        }
        else
        {
            //FILE NOT AVAILABLE
           Utils().downloadImagesSave(arrBoock[indexPath.row].ima_url, index: indexPath.row, callBack: { () -> Void in
            
             cell.setNeedsDisplay()
            
            
           })
            cell.imageView?.image = UIImage(named: "ebook.png")
        }
        
        cell.textLabel!.text = arrBoock[indexPath.row].title
        cell.detailTextLabel!.text  = arrBoock[indexPath.row].authors.joinWithSeparator(",")
        if arrBoock[indexPath.row].isFavorite == true {
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else{
        cell.accessoryType = UITableViewCellAccessoryType.None       }
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

 
    
    
    

}

