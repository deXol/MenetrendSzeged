//
//  RouteCollectionViewController.swift
//  MenetrendSzeged
//
//  Created by Toth Oliver on 6/4/18.
//  Copyright © 2018 deXol. All rights reserved.
//

import UIKit

private let reuseIdentifier = "routeCell"
private let routeSectionHeaderView = "routeSectionView"

class RouteCollectionViewController: UICollectionViewController  {
    
    private var trams = [Route]()
    private var trolleys = [Route]()
    private var busses = [Route]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        let routes = ScheduleDBManager.instance().getRoutes()
        trams = routes.filter { $0.type == .Tram }
        trolleys = routes.filter { $0.type == .Trolley }
        trolleys.sort()
        busses = routes.filter { $0.type == .Bus }
        busses.sort()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return trams.count
        case 1:
            return trolleys.count
        case 2:
            return busses.count
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RouteCollectionViewCell
        
        switch indexPath.section
        {
        case 0:
            let item = trams[indexPath.item].shortName
            cell.routeName.text = item
        case 1:
            let item = trolleys[indexPath.item].shortName
            cell.routeName.text = item
        case 2:
            let item = busses[indexPath.item].shortName
            cell.routeName.text = item
        default:
            cell.routeName.text = "Error"
        }

        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: routeSectionHeaderView, for: indexPath) as! RouteCollectionReusableView
        
        switch indexPath.section
        {
        case 0:
            sectionHeaderView.routeTitle = "Tram"
            sectionHeaderView.backgroundColor = UIColor.yellow
        case 1:
            sectionHeaderView.routeTitle = "Trolley"
            sectionHeaderView.backgroundColor = UIColor.red
        case 2:
            sectionHeaderView.routeTitle = "Bus"
            sectionHeaderView.backgroundColor = UIColor.blue
        default:
            sectionHeaderView.routeTitle = "Error"
        }
        
        return sectionHeaderView
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
