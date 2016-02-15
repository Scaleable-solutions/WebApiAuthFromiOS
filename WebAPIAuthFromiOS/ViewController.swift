//
//  ViewController.swift
//  WebAPIAuthFromiOS
//
//  Created by Hamza on 12/02/2016.
//  Copyright © 2016 Scaleable Solutions. All rights reserved.
//

import UIKit
import ADALiOS

class ViewController: UIViewController, NetworkDelegate {

    var er:ADAuthenticationError? = nil
    var authContext:ADAuthenticationContext? = nil
    
    @IBOutlet weak var DomainTextField: UITextField!
    
    var name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finishWithError(error: String, tag: String) {
        
    }
    
    func finishWithSuccess(response: NSData, tag: String) {
        if tag == "WhoAmI"{
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(response, options: .AllowFragments)
                if let User_id = json["UserId"] as? String{
                    let URL = "\(DomainTextField.text!)\(Constants.WebAPI_URLs.FullNameRequest_URL)"
                    let destinationURL = URL.stringByReplacingOccurrencesOfString("???", withString: User_id)
                    let storage:DefaultsStorage = DefaultsStorage()
                    authContext?.acquireTokenWithResource(storage.getDomain(), clientId: Constants.Client_Id, redirectUri: Constants.Redirect_URL){(result:ADAuthenticationResult!) in
                        let handler:ServiceHandler = ServiceHandler()
                        handler.tag = "UserInfo"
                        handler.delegate = self
                        handler.getMethod(result.accessToken, serviceURL: destinationURL)
                    }
                    
                }
            }catch{
                
            }
        }else if tag == "UserInfo"{
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(response, options: .AllowFragments)
                if let fullname = json["fullname"] as? String{
                    NSOperationQueue.mainQueue().addOperationWithBlock{
                        self.name = fullname
                        self.performSegueWithIdentifier("NameSegue", sender: self)
                    }
                }
            }catch{
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NameSegue"{
            let destinationVC = segue.destinationViewController as! NameViewController
            destinationVC.fullname = name
        }
    }
    
    @IBAction func submitAction(sender: UIButton) {
        let resource:String = DomainTextField.text!
        if DomainTextField.text!.isEmpty{
            let alert = UIAlertController(title: "Error", message:"Please Provide Domain", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                self.DomainTextField.becomeFirstResponder()
                
            })
            self.presentViewController(alert, animated: true){}
            return
        }
        if !matches(resource){
            let alert = UIAlertController(title: "Error", message:"Invalid Domain", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                self.DomainTextField.becomeFirstResponder()
                
            })
            self.presentViewController(alert, animated: true){}
            return
        }
        let storage:DefaultsStorage = DefaultsStorage()
        storage.saveDomain(resource)
        
        authContext = ADAuthenticationContext(authority: Constants.authority, error: &er)
        authContext!.acquireTokenWithResource(resource, clientId: Constants.Client_Id, redirectUri: Constants.Redirect_URL){(result:ADAuthenticationResult!) in
            if(result.accessToken != nil){
                let handler:ServiceHandler = ServiceHandler()
                handler.tag = "WhoAmI"
                handler.delegate = self
                handler.getMethod(result.accessToken, serviceURL: "\(resource)\(Constants.WebAPI_URLs.WhoAmIRequest_URL)")
            }
        }
    }
    
    func matches(searchString:String)->Bool{
        let pattern = "https://[a-z]*.crm[2-9]?.dynamics.com"
        do{
            let regex = try NSRegularExpression(pattern: pattern, options: [.CaseInsensitive])
            let matchCount = regex.numberOfMatchesInString(searchString, options: [], range: NSMakeRange(0, searchString.characters.count))
            
            return matchCount > 0
        }catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
}

