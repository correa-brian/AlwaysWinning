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
    var clouds = Array<UIImageView>()
    
    var optionsArray = ["Lebron James", "Bryce Harper", "Cam Newton"]
    var cloudImagesArray = ["cloud-1.png", "cloud-2.png", "cloud-3.png"]
    
    //MARK: Lifecycle Methods
    
    override func loadView() {
        
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor(red: 126/255, green: 192/255, blue: 238/255, alpha: 1.0)
        
        let dimen = frame.size.width
        var padding = CGFloat(60)
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
        
        padding = frame.size.width*0.3
        var x = CGFloat(0)
        y = frame.size.height*0.3
        
        for i in 0..<3{
            let cloud = UIImageView(frame: CGRect(x: x, y: y, width: 159, height: 50))
            cloud.tag = Int(x)
            
            let image = cloudImagesArray[i]
            
            cloud.image = UIImage(named: image)
            
            view.addSubview(cloud)
            self.clouds.append(cloud)
            x += padding
            y += padding
        }
        
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<self.cloudImagesArray.count{
            
            let width = Int(view.frame.size.width)
            let offScreen = Int(self.clouds[i].frame.origin.x)
            let speed = 60.0/view.frame.size.width
            let duration = view.frame.size.width * speed
            
            UIView.animateWithDuration(NSTimeInterval(duration),
                                       delay: 0.0,
                                       options: .CurveLinear,
                                       animations: {
                                        
                                        let cloud = self.clouds[i]
                                        var cloudFrame = cloud.frame
                                        cloudFrame.origin.x = CGFloat(cloud.tag + (width-offScreen))
                                        cloud.frame = cloudFrame
                                        
                },
                                       completion: nil)

        }
        
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
