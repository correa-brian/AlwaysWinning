//
//  IGHomeViewControlllerViewController.swift
//  instagram-api
//
//  Created by Brian Correa on 4/17/16.
//  Copyright © 2016 milkshake-systems. All rights reserved.
//

import UIKit
import Alamofire

class IGHomeViewControlllerViewController: IGViewController {

    //MARK: Properties
    
    var jamesBtn: UIButton!
    var harperBtn: UIButton!
    var newtonBtn: UIButton!
    var buttons = Array<UIButton>()
    var optionsArray = ["Lebron James", "Bryce Harper", "Cam Newton"]
    
    //MARK: Lifecycle Methods
    
    override func loadView() {
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.whiteColor()
        
        let dimen = frame.size.width
        let padding = CGFloat(60)
        var y = frame.size.height*0.5 - 160
        
        let height = CGFloat(44)
        let width = dimen-2*padding
        let blue = UIColor.blueColor()
        
        for i in 0..<3 {
            let btn = UIButton(type: .Custom)
            btn.frame = CGRect(x: padding, y: y, width: width, height: height)
            btn.tag = Int(y)
            
            btn.layer.borderColor = UIColor.blueColor().CGColor
            btn.layer.borderWidth = 2.0
            btn.layer.cornerRadius = 0.5*height
            btn.layer.masksToBounds = true
            btn.setTitleColor(blue, forState: .Normal)
            
            let text = optionsArray[i]
            
            btn.setTitle(text, forState: .Normal)
            btn.addTarget(self, action: #selector(IGHomeViewControlllerViewController.showNextController(_:)), forControlEvents: .TouchUpInside)
            
            view.addSubview(btn)
            self.buttons.append(btn)
            y += btn.frame.size.height+padding
        }
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showNextController(sender: UIButton){
        
        let nextVc = IGFeedViewController()
        nextVc.title = sender.currentTitle
       
        self.navigationController?.pushViewController(nextVc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
