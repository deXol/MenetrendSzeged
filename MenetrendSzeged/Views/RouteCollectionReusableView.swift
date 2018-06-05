//
//  RouteCollectionReusableView.swift
//  MenetrendSzeged
//
//  Created by Toth Oliver on 6/5/18.
//  Copyright © 2018 deXol. All rights reserved.
//

import UIKit

class RouteCollectionReusableView: UICollectionReusableView {
    
    
    @IBOutlet weak var routeSectionLabel: UILabel!
    
    var routeTitle: String! {
        didSet {
            routeSectionLabel.text = routeTitle
        }
    }
}
