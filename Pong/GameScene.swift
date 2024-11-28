//
//  GameScene.swift
//  Pong
//
//  Version 1.0 created by Ray Huang on 2023/1/8 .
//  Version 1.1 created by Ray Huang on 2024/9/15 .
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {

    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var playPause = SKSpriteNode()
    var hiddenLabel = SKLabelNode()

    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()

    var score = [Int]()

    var pingPongSoundEffect: AVAudioPlayer?

    override func didMove(to view: SKView) {
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode

        ball = self.childNode(withName:"ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50

        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50

        playPause.position.y = 0
        playPause.position.x = 0

        ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))

        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border

        startGame()

        self.physicsWorld.contactDelegate = self

        setupSoundEffects()
        
        hiddenLabel = SKLabelNode(text: "")
                hiddenLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                hiddenLabel.fontColor = .clear
                hiddenLabel.fontSize = 50
                self.addChild(hiddenLabel)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
                doubleTapRecognizer.numberOfTapsRequired = 2
                self.view?.addGestureRecognizer(doubleTapRecognizer)
        
        
    }

    @objc func handleDoubleTap() {
            //[Debug]print("Double tap detected, calling gameOver...")
            gameOver()
        }
    
    func setupSoundEffects() {
        if let path = Bundle.main.path(forResource: "PingPongSoundEffect", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                pingPongSoundEffect = try AVAudioPlayer(contentsOf: url)
                pingPongSoundEffect?.prepareToPlay()
            } catch {
                //[Debug]print("Error loading PingPongSoundEffect.mp3")
            }
        }
    }

    func startGame() {
        score = [0, 0]
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    }

    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        } else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
        
        if score[0] >= 5 || score[1] >= 5 {
                //[Debug]print("Game Over condition met!")
                gameOver()
            }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }

            let touchedNode = atPoint(location)
            if touchedNode.name == "playPause" {
                isPaused.toggle()
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.155))
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.14))
        case .player2:
            break
        }

        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        } else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: main)
        }
    }

    
    func didBegin(_ contact: SKPhysicsContact) {
        
        pingPongSoundEffect?.play()
    }
    
    func gameOver() {
        if let viewController = self.view?.window?.rootViewController as? GameViewController {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        viewController.returnToMenu()
                    }
                } else if let navigationController = self.view?.window?.rootViewController as? UINavigationController {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        navigationController.popViewController(animated: true)
                    }
                }
    }
}

