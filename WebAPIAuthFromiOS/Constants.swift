//
//  Constants.swift
//  WebAPIAuthFromiOS
//
//  Created by Hamza on 15/02/2016.
//  Copyright © 2016 Scaleable Solutions. All rights reserved.
//

import Foundation

struct Constants {
    
    static let authority:String = "https://login.windows.net/common";
    static let Client_Id:String = "<Provide your Client_Id>"
    static let Redirect_URL:NSURL = NSURL(string: "<Provide your Redirect_URL>")!
    
    struct WebAPI_URLs {
        static let WhoAmIRequest_URL:String = "/api/data/v8.0/WhoAmI"
        static let FullNameRequest_URL:String = "/api/data/v8.0/systemusers(???)?$select=fullname"
    }
}