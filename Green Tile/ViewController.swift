//
//  ViewController.swift
//  Green Tile
//
//  Created by Ty Victorson on 12/19/16.
//  Copyright © 2016 Xision. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ViewController: UIViewController {

    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // saves score
        let defaults: UserDefaults = UserDefaults.standard
        let savedScore = defaults.integer(forKey: "highScore")
        highScore = savedScore
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GameViewController
        vc.highScore = highScore
    }
}

