# Pong 

This is a simple Pong game developed in Swift for iOS. It has three levels of difficulty: easy, medium, and hard, as well as a two-player mode.

### Installation

To install the game, simply clone the repository and open it in Xcode. You can then build and run the game on your iOS device or simulator.

### Usage

Once you launch the game, you will be presented with a menu screen that allows you to select the game mode. Tap on one of the buttons to choose the level of difficulty or two-player mode. The game will start immediately once you select a mode.

### Code Overview
The code for the game is divided into three parts:

1. GameScene.swift: This file contains the code for the main game scene, where the gameplay logic and physics are implemented. It defines the ball, paddles, and boundaries of the game area, as well as the collision and movement behavior of these objects.

2. GameViewController.swift: This file sets up the initial view of the game, loads the game scene, and handles device orientation and status bar preferences.

3. MenuVC.swift: This file contains the code for the menu screen, which allows the player to select the game mode. It defines the gameType enum and the moveToGame function, which sets the current game type and pushes the game view controller onto the navigation stack.

### Contributing
Contributions to the game are welcome. If you find a bug or have a suggestion for a new feature, please create a pull request or open an issue on the repository.

### License
This project is licensed under the MIT License - see the LICENSE file for details.
