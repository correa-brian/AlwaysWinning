//
//  IGFeedViewController.swift
//  instagram-api
//
//  Created by Brian Correa on 4/13/16.
//  Copyright © 2016 milkshake-systems. All rights reserved.
//

import UIKit
import Alamofire

class IGFeedViewController: IGViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    
    var itemsTable: UITableView!
    var itemsArray = Array<IGItem>()
    
    //MARK: Lifecycle Methods
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor(red: 126/255, green: 192/255, blue: 238/255, alpha: 1.0)
        
        
        self.itemsTable = UITableView(frame: frame, style: .Plain)
        self.itemsTable.dataSource = self
        self.itemsTable.delegate = self
        
        view.addSubview(self.itemsTable)
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = ""
        
        if (self.title == "Lebron James"){
            url = "https://www.instagram.com/kingjames/media/"
        }
        
        if(self.title == "Bryce Harper"){
            url = "https://www.instagram.com/bharper3407/media/"
        }
        if(self.title == "Cam Newton"){
            url = "https://www.instagram.com/cameron1newton/media/"
        }

        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            if let JSON = response.result.value as? Dictionary<String, AnyObject>{
//                print("\(JSON)")
                
                if let items = JSON["items"] as? Array<Dictionary<String, AnyObject>>{
//                    print("\(items)")
                
                    for itemInfo in items {
//                        print("ITEM---------\(itemInfo)")
                        
                        let item = IGItem()
                        item.populate(itemInfo)
                        //Key Value Observation (kvo)
                        self.itemsArray.append(item)
                    }
                    
                    self.itemsTable.reloadData()
                }
            }
        }
        
    }
    
    //MARK: Callback (Observation) Method
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if (keyPath == "image"){
//            print("IMAGE DOWNLOADED")
            
            dispatch_async(dispatch_get_main_queue(), {
                let item = object as? IGItem
                item?.removeObserver(self, forKeyPath: "image")
                self.itemsTable.reloadData()
            })
            
        }
    }
    
    //MARK: Configure Cell
    
    func configureCell(cell: BCTableViewCell, indexPath: NSIndexPath) -> UITableViewCell {
        
        let item = self.itemsArray[indexPath.row]
        
        cell.textLabel?.text = item.caption
        cell.detailTextLabel?.text = "\(item.comments.count) comments"
        
        if (item.image == nil){
            cell.imageView?.image = nil
            item.addObserver(self, forKeyPath: "image", options: .Initial, context: nil)
            item.fetchImage()
            return cell
        }
        
        cell.imageView?.image = item.image
        return cell
        
    }
    
    //MARK: Table Delegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.itemsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "cellId"
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? BCTableViewCell {
            return self.configureCell(cell, indexPath: indexPath)
        }
        
        let cell = BCTableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        return self.configureCell(cell, indexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let item = self.itemsArray[indexPath.row]
        
        let imageVC = IGImageViewController()
        imageVC.item = item
        self.navigationController?.pushViewController(imageVC, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
