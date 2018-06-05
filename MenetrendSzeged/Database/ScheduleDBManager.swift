//
//  ScheduleDB.swift
//  MenetrendTest
//
//  Created by Toth Oliver on 5/31/18.
//  Copyright © 2018 deXol. All rights reserved.
//

import Foundation
import SQLite3

class ScheduleDBManager
{
    static private var scheduleDBManeger: ScheduleDBManager? = nil
    var db: OpaquePointer? = nil
    let DB_NAME: String = "SzegedSchedule.db"
    var dbPath: String
    
    static public func instance() -> ScheduleDBManager
    {
        if nil == scheduleDBManeger
        {
            scheduleDBManeger = ScheduleDBManager()
        }

        return scheduleDBManeger!

    }
    
    private init() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(DB_NAME)
        dbPath = fileURL.absoluteString
        var dbNameParts = DB_NAME.components(separatedBy: ".")
        do
        {
            try FileManager.default.copyfileToUserDocumentDirectory(forResource: dbNameParts[0],
                                                                    ofType: dbNameParts[1])
        }
        catch
        {
            print("Unable to Copy db file to document dir, did not found at \(dbPath)")
            print("Error: \(error).")
        }
        openDatabase()
    }
    
    
    private func openDatabase()
    {
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(dbPath)")
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
        }
    }
    
    public func getRoutes() -> [Route] {
        var routes = [Route]()
        var queryStatement: OpaquePointer? = nil
        let queryStatementString = "SELECT * FROM routes ORDER BY route_short_name"
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {

                let id = Int(sqlite3_column_int(queryStatement, 0))
                let agencyId = Int(sqlite3_column_int(queryStatement, 1))
                let shortName = String(cString: sqlite3_column_text(queryStatement!, 2))
                let startEndName = String(cString: sqlite3_column_text(queryStatement!, 3))
                let description = String(cString: sqlite3_column_text(queryStatement!, 4))
                let type = Int(sqlite3_column_int(queryStatement, 5))
                let url = String(cString: sqlite3_column_text(queryStatement!, 6))
                let color = String(cString: sqlite3_column_text(queryStatement!, 7))
                let textColor = String(cString: sqlite3_column_text(queryStatement!, 8))
                
                routes.append(Route(id: id, agencyId: agencyId, shortName: shortName, startEndName: startEndName, description: description, type: type, url: url, color: color, textColor: textColor))
                
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            print("SELECT statement could not be prepared")
        }
        
        // 6
        sqlite3_finalize(queryStatement)
        
        return routes
    }
    
    public func getAgencies() -> [Agency] {
        var agencies = [Agency]()
        var queryStatement: OpaquePointer? = nil
        let queryStatementString = "SELECT * FROM agency"
 
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {

            while sqlite3_step(queryStatement) == SQLITE_ROW {

                let id = Int(sqlite3_column_int(queryStatement, 0))
                let name = String(cString: sqlite3_column_text(queryStatement!, 1))
                let url = String(cString: sqlite3_column_text(queryStatement!, 2))
                let timezone = String(cString: sqlite3_column_text(queryStatement!, 3))
                let phoneNumber = String(cString: sqlite3_column_text(queryStatement!, 4))
                let language = String(cString: sqlite3_column_text(queryStatement!, 5))
                
                agencies.append(Agency(id: id, name: name, url: url, timezone: timezone, phoneNumber: phoneNumber, language: language))
                
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        
        return agencies
    }
}
