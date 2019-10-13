//
//  ViewController.swift
//  Word Garden
//
//  Created by Kyle Gil Tan on 9/15/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuestLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    
    func updateUIAfterGuess(){
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    func guessALetter(){
        formatUserGuestLabel()
        guessCount += 1
        
        let currentLetterGuessed = guessedLetterField.text!
        let revealedWord = userGuessLabel.text!
        //decrements wrong guesses remaining, shows the next flower image with one less petal
        if !wordToGuess.contains(currentLetterGuessed){
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        //stop game if wrongGuessesRemaining = 0
        if wrongGuessesRemaining == 0{
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "So sorry you are all out of guesses. Try again?"
        }
        else if !revealedWord.contains("_"){
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You've got it! It took you \(guessCount) guesses to guess the word!"
        }
        else{
            //let guess = (guessCount == 1 ? "guess" : "guesses" )
            var guess = "Guesses"
            if guessCount == 1{
                guess = "Guess"
            }
            guessCountLabel.text = "You've Made \(guessCount) \(guess)"
        }
    }
    
    func formatUserGuestLabel(){
        var revealedWord = " "
        lettersGuessed += guessedLetterField.text!
        for letter in wordToGuess{
            if lettersGuessed.contains(letter){
                revealedWord = revealedWord + "\(letter)"
            }
            else{
                revealedWord += " _"
            }
            //revealedWord.removeFirst()
            userGuessLabel.text = revealedWord
        }
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextView) {
        if let letterGuessed = guessedLetterField.text!.last{
            guessedLetterField.text = String(letterGuessed)
            guessLetterButton.isEnabled = true
        }
        else{
            //disable the button if there is no single character in the guessedLetterField
            guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuestLabel()
        guessCountLabel.text = "You've Made 0 Guesses"
        guessCount = 0
    }
    
}

