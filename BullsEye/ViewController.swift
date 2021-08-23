//
//  ViewController.swift
//  BullsEye
//
//  Created by Josue Mendoza on 8/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var targetLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var roundLabel: UILabel!
        
    //This is the initial variable value of the slider when you hit the "Hit Me!" button on the app.
    var currentValue = 0
    
    //This is the variable for the random number generator of the "targetValue"(100)
    var targetValue = 0
    
    //This is the variable for the score
    var score = 0
    
    var round = 0

    //This method converts an Int(object) into a String(object) by updating the Int. Strings
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    //This is the "Method" to start a new round. The advantage of having a method, is if you need to call it later on in another func, you only need to call the name ("starNewRound") of the method. Also, if you need to add/delete syntex, you do it in one place.
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)//Adding ".random" after "Float" places the slider random position during a New Round, instead of the halfway mark of 50
        updateLabels()
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
        
        //This method creates a smooth transition into a newround.
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(
            name:CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()  //When this is called, it reverts back to the "startNewRound" Method
       
        //This will generate a random number unto the "targetValue" Label (100)
        targetValue = Int.random(in: 1...100)
        
        //This is the method which changes the sliders standard button icon, to the image in my asset folder.
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        //This is the same method as above, only it "highlights" the image
        let thumbImageHighLighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighLighted, for: .highlighted)
        
        let insets = UIEdgeInsets(
            top: 0,
            left: 14,
            bottom: 0,
            right: 14)
        
        //This method changes the color/size of the slider bar when it shifts to the left, to the image in the asset folder.
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        //This method changes the color/size of the slider bar when it shifts to the right, to the image in the asset folder.
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
//This is the function that brings up the alert pop-up screen.
    @IBAction func showAlert() {
        
        //This is the algorithm that calculates the score for the current round
        let difference = abs(targetValue - currentValue)
        
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "BULLS EYE!!"
            points += 900 //This increases the points title message to 1000. 100 + 900
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1{
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty Good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        
        let message = "Target value was: \(targetValue)" +
        "\n Your current value is: \(currentValue)" + "\n" +
        "\n You scored: \(points) points"
        
        //This is the constant that displays the alert pop-up screen.
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        //This is the constant that initiates the pop-up screen after a user clicks on it.
        let action = UIAlertAction(
            title: "OK",
            style: .default) {_ in
                self.startNewRound() //When this is called, it reverts back to the "startNewRound" Method
            }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    //This provides the value of where the user placed the slider.
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)    }
}

