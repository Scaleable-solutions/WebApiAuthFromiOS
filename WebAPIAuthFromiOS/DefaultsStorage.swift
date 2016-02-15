//
//  DefaultsStorage.swift
//  WebAPIAuthFromiOS
//
//  Created by Hamza on 15/02/2016.
//  Copyright © 2016 Scaleable Solutions. All rights reserved.
//

import Foundation

class DefaultsStorage{
    
    func saveDomain(domain:String){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(domain, forKey: "domain")
    }
    
    func getDomain() -> String{
        let defaults = NSUserDefaults.standardUserDefaults()
        if let domain = defaults.stringForKey("domain"){
            return domain
        }
        return ""
    }
    
    func removeDomain(){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("domain")
    }
}
