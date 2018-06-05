//
//  Agency.swift
//  MenetrendTest
//
//  Created by Toth Oliver on 6/3/18.
//  Copyright © 2018 deXol. All rights reserved.
//

import Foundation

class Agency {

    
    var id: Int
    var name: String
    var url: String
    var timezone: String
    var phoneNumber: String
    var language: String
    
    init(id: Int, name: String, url: String, timezone: String, phoneNumber: String, language: String){
        self.id = id
        self.name = name
        self.url = url
        self.timezone = timezone
        self.phoneNumber = phoneNumber
        self.language = language
    }
}
