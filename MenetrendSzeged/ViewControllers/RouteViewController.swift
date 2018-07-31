//
//  RouteViewController.swift
//  MenetrendSzeged
//
//  Created by Toth Oliver on 7/31/18.
//  Copyright © 2018 deXol. All rights reserved.
//

import UIKit

class RouteViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var route: Route?
    {
        didSet
        {
            navigationItem.title = route?.shortName
        }
    }
    
    @IBOutlet weak var routeNameLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createWays()
        routeNameLabel.text = route?.startEndName
        wayPicker.dataSource = self
        wayPicker.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - WayPicker
    @IBOutlet weak var wayPicker: UIPickerView!
    var ways = [String]()
    
    func createWays()
    {
        ways = (route?.startEndName.components(separatedBy: " / "))!
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ways.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ways[row]
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
