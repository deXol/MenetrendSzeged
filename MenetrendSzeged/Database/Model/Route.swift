//
//  Routes.swift
//  MenetrendTest
//
//  Created by Toth Oliver on 6/3/18.
//  Copyright © 2018 deXol. All rights reserved.
//

import Foundation

class Route : Comparable
{

    enum RouteType: Int
    {
        case Tram = 0
        case Bus = 3
        case Trolley = 800
    }
    
    var id: Int
    var agencyId: Int
    var shortName: String
    var startEndName: String
    var description: String
    var type: RouteType
    var url: String
    var color: String
    var textColor: String
    var routeNum: Int
    var routeChar: String

    init(id: Int, agencyId: Int, shortName: String, startEndName: String, description: String,
         type: Int, url: String, color: String, textColor: String)
    {
        self.id = id
        self.agencyId = agencyId
        self.shortName = shortName
        self.startEndName = startEndName
        self.description = description
        self.type = RouteType(rawValue: type) ?? .Bus
        self.url = url
        self.color = color
        self.textColor = color
        var routeNumPart = ""
        self.routeChar = ""
        for c in self.shortName
        {
            if c >= "0" && c <= "9"
            {
                routeNumPart += String(c)
            }
            else
            {
                self.routeChar += String(c)
            }
        }
        routeNum = Int(routeNumPart) ?? 0
    }
    
    static func < (lhs: Route, rhs: Route) -> Bool {
        
        if lhs.routeNum < rhs.routeNum
        {
            return true
        }
        else if lhs.routeNum == rhs.routeNum
        {
            if lhs.routeChar < rhs.routeChar
            {
                return true
            }
            else
            {
                return false
            }
        }
        else
        {
            return false
        }
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.shortName == rhs.shortName
    }
}
