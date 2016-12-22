//
//  GameViewController.swift
//  Green Tile
//
//  Created by Ty Victorson on 12/19/16.
//  Copyright © 2016 Xision. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AVAudioPlayerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var highScore = 0
    var score = 0
    var time = 3
    var timer = Timer()
    var random = 0
    var correct = AVAudioPlayer()
    var wrong = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets up and starts timer using the update method
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        correct = self.setupAudioPlayerWithFile("correct", type:"mp3")
        wrong = self.setupAudioPlayerWithFile("wrong", type:"mp3")
    }
    
    //update method called by the timer
    func update() {
        time -= 1
        timeLabel.text = "Time Left: \(time)"
        
        if time == 0 {
            timer.invalidate()
            //segue to next view
            if let resultController = self.storyboard?.instantiateViewController(withIdentifier: "EndVC") as? EndViewController {
                resultController.score = score
                resultController.highScore = highScore
                self.present(resultController, animated: true, completion: nil)
            }

        }
    }
    
    // sets up the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    // adds points an edns game
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == random) {
            score += 1
            highScoreLabel.text = "Score: \(score)"
            time = 3
            correct.play()
            collectionView.reloadData()
        } else {
            wrong.play()
             time = 1
        }
    }
    
    // sets up the cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CellController
        random = (Int)(arc4random_uniform(4))
        if (indexPath.row == random) {
            cell.backgroundColor = UIColor.green
        } else {
            cell.backgroundColor = UIColor.red
        }
        return cell
    }
    
    // Sound setup
    func setupAudioPlayerWithFile(_ file:NSString, type:NSString) -> AVAudioPlayer  {
        //1
        let path = Bundle.main.path(forResource: file as String, ofType:type as String)
        let url = URL(fileURLWithPath: path!)
        
        //2
        var audioPlayer:AVAudioPlayer?
        
        // 3
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
        } catch {
            print("Player not available")
        }
        
        //4
        return audioPlayer!
    }

}
