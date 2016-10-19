//
//  ViewController.swift
//  retro_calc
//
//  Created by Saumya Raval on 9/12/16.
//  Copyright © 2016 Saumya Raval. All rights reserved.
//
//Added a comment

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var CurrentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print (err.debugDescription)
        }
    }

    @IBAction func numberPressed(btn: UIButton!) {
        btnSound.play()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMulPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(CurrentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        CurrentOperation = Operation.Empty
        result = ""
        outputLbl.text = "0"
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if CurrentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if CurrentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if CurrentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if CurrentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if CurrentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }

            
            CurrentOperation = op
        }
        else {
            if runningNumber == "" {
                leftValStr = "0"
                runningNumber = ""
                CurrentOperation = op
            }
            else {
            leftValStr = runningNumber
            runningNumber = ""
            CurrentOperation = op
            }
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
}

	