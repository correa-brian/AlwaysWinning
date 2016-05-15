//
//  IGImageViewController.swift
//  instagram-api
//
//  Created by Brian Correa on 4/14/16.
//  Copyright © 2016 milkshake-systems. All rights reserved.
//

import UIKit

class IGImageViewController: IGViewController, UITableViewDelegate, UITableViewDataSource {
    
    var item = IGItem()
    var commentsTable: UITableView!
    var itemImageView: UIImageView!
    var lblCaption: UILabel!
    var lblDate: UILabel!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.edgesForExtendedLayout = .None
    }
    
    override func loadView() {
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.whiteColor()
        
        self.itemImageView = UIImageView(image: self.item.image)
        self.itemImageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width)
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.itemImageView.bounds
        let blk = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        gradient.colors = [UIColor.clearColor().CGColor, blk.CGColor]
        self.itemImageView.layer.insertSublayer(gradient, atIndex: 0)
        view.addSubview(self.itemImageView)
        
        let font = UIFont.systemFontOfSize(16)
        let cap = NSString(string: self.item.caption)
        let bounds = cap.boundingRectWithSize(CGSizeMake(frame.size.width-24, 1000),
                                              options: .UsesLineFragmentOrigin,
                                              attributes: [NSFontAttributeName:font],
                                              context: nil)
        let height = bounds.size.height
        
        self.lblCaption = UILabel(frame: CGRect(x: 12, y: self.itemImageView.frame.size.height-height-12, width: frame.size.width-24, height: height))
        self.lblCaption.lineBreakMode = .ByWordWrapping
        self.lblCaption.numberOfLines = 0
        self.lblCaption.textColor = UIColor.whiteColor()
        self.lblCaption.font = font
        self.lblCaption.text = self.item.caption
        view.addSubview(self.lblCaption)
        
        self.commentsTable = UITableView(frame: frame, style: .Plain)
        self.commentsTable.delegate = self
        self.commentsTable.dataSource = self
        self.commentsTable.contentInset = UIEdgeInsetsMake(frame.size.width, 0.0, 0.0, 0.0)
        self.commentsTable.separatorStyle = .None
        self.commentsTable.backgroundColor = UIColor.clearColor()
        
        view.addSubview(commentsTable)
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        let offsetY = -1*scrollView.contentOffset.y
        
        let max = scrollView.frame.size.width
        let min = 0.5*max
        let span = max-min
        
        let delta = max-offsetY
        let alpha = (min-delta)/span
        
        self.itemImageView.alpha = alpha
        
    }
    
    //Mark: Table Delegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cellId"
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId){
            return self.configureCell(cell, indexPath: indexPath)
        }
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        return self.configureCell(cell, indexPath: indexPath)
        
    }
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) -> UITableViewCell {
        
        cell.textLabel?.text = self.item.comments[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
