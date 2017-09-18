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
        let postLocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "postLocation")
        self.present(postLocationViewController!, animated: true, completion: nil)
    }

    func closeModal(){
        
    
    }
    
    func prepareActivityIndicator()-> UIActivityIndicatorView{
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        return activityIndicator
    }
    
    
    func displayError(title:String, message:String, dismissMessage:String){
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: dismissMessage, style: .default){ action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func performLogOut(){
        
        let authService =  AuthService()
        authService.performLogout(){
            (response, error) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            
        }
    }
    
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
        
        
    }
    
    func keyboardWillHide (_ notification:Notification){
        view.frame.origin.y = 0
    }
    
}
