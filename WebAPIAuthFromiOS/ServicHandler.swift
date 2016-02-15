//
//  ServicHandler.swift
//  WebAPIAuthFromiOS
//
//  Created by Hamza on 15/02/2016.
//  Copyright © 2016 Scaleable Solutions. All rights reserved.
//

import Foundation

protocol NetworkDelegate{
    
    func finishWithError(error:String,tag:String)
    
    func finishWithSuccess(response:NSData,tag:String)
}

class ServiceHandler {
    
    var delegate:NetworkDelegate? = nil
    var tag:String? = nil
    
    func getMethod(accessToken:String, serviceURL:String){
        let request = NSMutableURLRequest(URL: NSURL(string: serviceURL)!)
        request.HTTPMethod = "GET"
        request.setValue("application/json; odata=verbose", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            
            if error != nil{
                self.delegate?.finishWithError((error?.description)!, tag: self.tag!)
                return
            }
            self.delegate?.finishWithSuccess(data!, tag: self.tag!)
        }
        task.resume()
    }
}