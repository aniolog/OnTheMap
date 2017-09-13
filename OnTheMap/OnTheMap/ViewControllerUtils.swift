//
//  ViewControllerUtils.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/12/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{

    func prepareNavigationBarButtons(){
        //Mark: left button
        let leftButton = UIButton.init(type: .custom)
        leftButton.setImage(UIImage(named: "icon_back-arrow"), for: UIControlState.normal)
        leftButton.addTarget(self, action: #selector(self.performLogOut), for: UIControlEvents.touchUpInside)
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftButton.imageView?.contentMode = .scaleAspectFit
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        // Mark: right button
        let rightButton = UIButton.init(type: .custom)
        rightButton.setImage(UIImage(named: "icon_world"), for: UIControlState.normal)
        rightButton.addTarget(self, action: #selector(self.pinUser), for: UIControlEvents.touchUpInside)
        rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightButton.imageView?.contentMode = .scaleAspectFit
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationItem.title = "On the map"
    }

    func pinUser(){
    
    }

    
    func performLogOut(){
        self.dismiss(animated: true, completion: nil)
    
    }

}
