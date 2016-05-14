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
        view.backgroundColor = UIColor(red: 126/255, green: 192/255, blue: 238/255, alpha: 1.0)
        
        let dimen = frame.size.width
        let padding = CGFloat(60)
        var y = frame.size.height*0.5 - 160
        
        let height = CGFloat(44)
        let width = dimen-2*padding
        let white = UIColor.whiteColor()
        
        for i in 0..<3 {
            let btn = UIButton(type: .Custom)
            btn.frame = CGRect(x: padding, y: y, width: width, height: height)
            btn.tag = Int(y)
            
            btn.layer.borderColor = white.CGColor
            btn.layer.borderWidth = 2.0
            btn.layer.cornerRadius = 0.5*height
            btn.layer.masksToBounds = true
            btn.setTitleColor(white, forState: .Normal)
            
            let text = optionsArray[i]
            
            btn.setTitle(text, forState: .Normal)
            btn.addTarget(self, action: #selector(IGHomeViewControlllerViewController.showNextController(_:)), forControlEvents: .TouchUpInside)
            
            view.addSubview(btn)
            self.buttons.append(btn)
            y += btn.frame.size.height+padding
         
        }
        
        let cloud1 = UIImageView(frame: CGRect(x: 100, y: 500, width: 159, height: 50))
        cloud1.image = UIImage(named: "cloud-1.png")
        view.addSubview(cloud1)

        let cloud2 = UIImageView(frame: CGRect(x: 200, y: 75, width: 159, height: 50))
        cloud2.image = UIImage(named: "cloud-2.png")
        view.addSubview(cloud2)
        
        let cloud3 = UIImageView(frame: CGRect(x: 50, y: 300, width: 159, height: 50))
        cloud3.image = UIImage(named: "cloud-3.png")
        view.addSubview(cloud3)
        
//        animateCloud(cloud1)
//        animateCloud(cloud2)
//        animateCloud(cloud3)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//    func animateCloud(cloud: UIImageView){
//        let speed = 60.0/view.frame.size.width
//        let duration = (view.frame.size.width - cloud.frame.origin.x) * speed
//        UIView.animateWithDuration(NSTimeInterval(duration), delay: 0.0, options: .CurveLinear, animations: {
//            cloud.frame.origin.x = self.view.frame.size.width
//            }, completion: {_ in
//                cloud.frame.origin.x = -cloud.frame.size.width
//                self.animateCloud(cloud)
//        })
//    }
    
    func showNextController(sender: UIButton){
        
        let nextVc = IGFeedViewController()
        nextVc.title = sender.currentTitle
       
        self.navigationController?.pushViewController(nextVc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
