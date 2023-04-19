//
//  MenuVC.swift
//  Pong
//
//  Created by Ray Huang on 2023/1/9.
//

import Foundation
import UIKit

let game_mode = 0


enum gameType {
    case easy
    case medium
    case hard
    case player2
}

class MenuVC: UIViewController{
    
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
        
        let player2 = UIImage(named:"twoPlayers2.png")
        Player2.setTitle("", for: .normal)
        Player2.setImage(player2, for: .normal)
        
        let easy = UIImage(named:"easy2.png")
        Easy.setTitle("", for: .normal)
        Easy.setImage(easy, for: .normal)
        
        let medium = UIImage(named:"medium2.png")
        Medium.setTitle("", for: .normal)
        Medium.setImage(medium, for: .normal)
        
        let hard = UIImage(named:"hard2.png")
        Hard.setTitle("", for: .normal)
        Hard.setImage(hard, for: .normal)
        
        
    }
    
    
    func moveToGame(game : gameType){
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC")as!GameViewController
        
            currentGameType = game
        
            self.navigationController?.pushViewController(gameVC, animated: true)
        
        
        
    }
    
    
    
    
}
