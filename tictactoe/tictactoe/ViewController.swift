//
//  ViewController.swift
//  tictactoe
//
//  Created by Marin Maslov on 09.02.2022..
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var currentPlayerLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    enum User: String {
        case playerX = "Player X"
        case playerO = "Player O"
    }
    
    var currentPlayer = User.playerX
    var playedBoxes = Set<Int>()
    var winningBoxes = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    var playerXBoxes = [Int]()
    var playerOBoxes = [Int]()
    
    var isGameWon = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttons = [button0, button1, button2, button3, button4, button5, button6, button7, button8]
        
        for button in buttons {
            button?.backgroundColor = UIColor.white
            button?.layer.cornerRadius = 5
        }
        
        currentPlayerLabel.text = User.playerX.rawValue
        title = "TicTacToe"
        
        restartButton.isHidden = true
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if !playedBoxes.contains(sender.tag) && !isGameWon {
            if currentPlayer == User.playerX {
                sender.setTitle("X", for: .normal)
                sender.tintColor = UIColor.white
                sender.backgroundColor = UIColor(red: 0.941, green: 0.655, blue: 0.937, alpha: 1.0)
                currentPlayer = User.playerO
                currentPlayerLabel.text = User.playerO.rawValue
                playedBoxes.insert(sender.tag)
                playerXBoxes.append(sender.tag)
            } else {
                sender.setTitle("O", for: .normal)
                sender.tintColor = UIColor.white
                sender.backgroundColor = UIColor(red: 0.506, green: 0.729, blue: 0.914, alpha: 1.0)
                currentPlayer = User.playerX
                currentPlayerLabel.text = User.playerX.rawValue
                playedBoxes.insert(sender.tag)
                playerOBoxes.append(sender.tag)
            }
        }
        
        checkIfWon()
    }
    
    func checkIfWon() {
        for sequence in winningBoxes {
            let seq = Set(sequence)
            let playerX = Set(playerXBoxes)
            let playerO = Set(playerOBoxes)
            
            print("Serija")
            print("SEQ: ")
            print(seq)
            print("X: ")
            print(playerX)
            print("O: ")
            print(playerO)

            if seq.isSubset(of: playerX) {
                currentPlayerLabel.text = "Player X won!"
                isGameWon = true
                restartButton.isHidden = false
                break
            } else if seq.isSubset(of: playerO) {
                currentPlayerLabel.text = "Player O won!"
                isGameWon = true
                restartButton.isHidden = false
                break
            } else if playedBoxes.count == 9 {
                currentPlayerLabel.text = "It's a tie!"
                restartButton.isHidden = false
            } else {
                print("An error occurred!")
            }
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        playerXBoxes = []
        playerOBoxes = []
        isGameWon = false
        currentPlayer = User.playerX
        currentPlayerLabel.text = User.playerX.rawValue
        playedBoxes = Set<Int>()
        restartButton.isHidden = true
        
        let buttons = [button0, button1, button2, button3, button4, button5, button6, button7, button8]
        
        for button in buttons {
            button?.setTitle("", for: .normal)
            button?.backgroundColor = UIColor.white
        }
    }
}
