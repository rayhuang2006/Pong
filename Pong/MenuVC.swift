//
//  MenuVC.swift
//  Pong
//
//  Version 1.0 created by Ray Huang on 2023/1/8 .
//  Version 1.1 created by Ray Huang on 2024/9/15 .
//


import UIKit
import AVFoundation
import Foundation

let game_mode = 0


enum gameType {
    case easy
    case medium
    case hard
    case player2
}

class MenuVC: UIViewController {

    var audioPlayer: AVAudioPlayer?

    @IBAction func Player2(_ sender: Any) {
        moveToGame(game: .player2)
    }
    @IBAction func Easy(_ sender: Any) {
        moveToGame(game: .easy)
    }
    @IBAction func Medium(_ sender: Any) {
        moveToGame(game: .medium)
    }
    @IBAction func Hard(_ sender: Any) {
        moveToGame(game: .hard)
    }

    @IBOutlet weak var Player2: UIButton!
    @IBOutlet weak var Easy: UIButton!
    @IBOutlet weak var Medium: UIButton!
    @IBOutlet weak var Hard: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let pongLabel = UILabel()
        pongLabel.text = "PONG"
        pongLabel.font = UIFont.boldSystemFont(ofSize: 60)
        pongLabel.textColor = UIColor.black
        pongLabel.textAlignment = .center
        
        let labelTopPadding: CGFloat = 250
        let labelHeight: CGFloat = 70
        pongLabel.frame = CGRect(x: 0, y: labelTopPadding, width: view.frame.size.width, height: labelHeight)
        
        view.addSubview(pongLabel)


        let player2 = UIImage(named: "twoPlayers2.png")
        Player2.setTitle("", for: .normal)
        Player2.setImage(player2, for: .normal)

        let easy = UIImage(named: "easy2.png")
        Easy.setTitle("", for: .normal)
        Easy.setImage(easy, for: .normal)

        let medium = UIImage(named: "medium2.png")
        Medium.setTitle("", for: .normal)
        Medium.setImage(medium, for: .normal)

        let hard = UIImage(named: "hard2.png")
        Hard.setTitle("", for: .normal)
        Hard.setImage(hard, for: .normal)


        let buttonVerticalSpacing: CGFloat = 30
        let buttonHeight: CGFloat = 50

        let firstButtonYPosition = pongLabel.frame.maxY + 50
        
        Player2.frame = CGRect(x: (view.frame.size.width - Player2.frame.size.width) / 2, y: firstButtonYPosition, width: Player2.frame.size.width, height: buttonHeight)

        Easy.frame = CGRect(x: (view.frame.size.width - Easy.frame.size.width) / 2, y: Player2.frame.maxY + buttonVerticalSpacing, width: Easy.frame.size.width, height: buttonHeight)

        Medium.frame = CGRect(x: (view.frame.size.width - Medium.frame.size.width) / 2, y: Easy.frame.maxY + buttonVerticalSpacing, width: Medium.frame.size.width, height: buttonHeight)

        Hard.frame = CGRect(x: (view.frame.size.width - Hard.frame.size.width) / 2, y: Medium.frame.maxY + buttonVerticalSpacing, width: Hard.frame.size.width, height: buttonHeight)

        playLobbyMusic()
    }


    func playLobbyMusic() {
        if let path = Bundle.main.path(forResource: "LobbyMusic", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.volume = 0.2
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
            } catch {
                print("Error loading and playing LobbyMusic.mp3")
            }
        }
    }


    func stopMusic() {
        audioPlayer?.stop()
    }


    func moveToGame(game: gameType) {
        stopMusic()
        
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        currentGameType = game
        self.navigationController?.pushViewController(gameVC, animated: true)
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playLobbyMusic()
    }
}

