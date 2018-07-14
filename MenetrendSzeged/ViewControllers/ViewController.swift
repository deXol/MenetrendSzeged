//
//  ViewController.swift
//  MenetrendSzeged
//
//  Created by Toth Oliver on 6/4/18.
//  Copyright © 2018 deXol. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DispatchQueue.global(qos: .background).async {
            let routes = ScheduleDBManager.instance().getRoutes()
            let result = routes.first(where: { $0.shortName == "71A"})
            let buses = routes.filter({$0.type == .Bus})
            print("Buses:")
            for bus in buses
            {
                print(bus.shortName)
            }
            DispatchQueue.main.async {
                self.testLabel.text = result!.startEndName
            }
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

