//
//  EndViewController.swift
//  Green Tile
//
//  Created by Ty Victorson on 12/19/16.
//  Copyright © 2016 Xision. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class EndViewController: UIViewController {

    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (score > highScore) {
            highScore = score
        }
        
        scoreLabel.text = "Score: \(score)"
        highScoreLabel.text = "High Score: \(highScore)"
        
        // saves high score and other booleans
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(highScore, forKey: "highScore")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GameViewController
        vc.highScore = highScore
    }
}
