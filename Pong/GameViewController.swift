//
//  GameViewController.swift
//  Pong
//
//  Version 1.0 created by Ray Huang on 2023/1/8 .
//  Version 1.1 created by Ray Huang on 2024/9/15 .
//


import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

var currentGameType = gameType.medium

class GameViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playGamePlayMusic()
        
        if let view = self.view as! SKView? {

            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                scene.size = view.bounds.size
                

                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }


    func playGamePlayMusic() {
        if let path = Bundle.main.path(forResource: "GamePlayMusic", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.volume = 0.1
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
            } catch {
                print("Error loading and playing GamePlayMusic.mp3")
            }
        }
    }


    func stopMusic() {
        audioPlayer?.stop()
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopMusic()
    }


    func returnToMenu() {
        self.navigationController?.popViewController(animated: true)
    }


    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }


    override var prefersStatusBarHidden: Bool {
        return true
    }
}

