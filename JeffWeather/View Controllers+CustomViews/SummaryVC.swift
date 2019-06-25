//
//  SummaryVC.swift
//  JeffWeather
//
//  Created by Jeff Glasse on 6/25/19.
//  Copyright © 2019 Jeff Glasse. All rights reserved.
//

import Foundation
import UIKit

class SummaryVC: UIViewController
{
    var summary: String = "Summary"
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        summaryLabel?.text = summary

    }
    
}
