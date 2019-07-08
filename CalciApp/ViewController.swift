//
//  ViewController.swift
//  CalciApp
//
//  Created by Sneha Harke on 23/03/19.
//  Copyright © 2019 Sneha Harke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scientificCalculatorWidth: NSLayoutConstraint! // 0 initial
    @IBOutlet weak var basicCalculatorWidth: NSLayoutConstraint!  // 396 initial
   
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var deviceWidth: CGFloat?
    var deviceHeight: CGFloat?
    
    //Math variables
    var firstNumber: Int = 0
    var secondNumber: Int = 0
    var result: Int = 0
    var isOperationBtnTapped:Bool = false
    
    var add = false
    var mult = false
    var div = false
    var sub = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deviceWidth = vScreenWidth
        self.deviceHeight = vScreenHeight
        if UIApplication.shared.statusBarOrientation == .landscapeLeft &&  UIApplication.shared.statusBarOrientation == .landscapeRight {
                scientificCalculatorWidth.constant = (deviceHeight ?? 0) - (deviceWidth ?? 0) - 2 + 60
                basicCalculatorWidth.constant = deviceHeight ?? 0 - 60
        } else {
            scientificCalculatorWidth.constant = 0
            basicCalculatorWidth.constant = vScreenWidth + 2
        }
        self.view.layoutIfNeeded()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
                scientificCalculatorWidth.constant = (deviceHeight ?? 0) - (deviceWidth ?? 0) - 2 + 60
                basicCalculatorWidth.constant =  deviceHeight ?? 0 - 60
            } else {
                scientificCalculatorWidth.constant = 0
                basicCalculatorWidth.constant = vScreenWidth + 2
        }
    }

    @IBAction func numberTapped(_ sender: UIButton) {
        if isOperationBtnTapped {
            calculationLabel.text = ""
            secondNumber = Int(calculationLabel.text ?? "0") ?? 0
            calculationLabel.text = String(secondNumber) + String(sender.tag)
            secondNumber =  Int(calculationLabel.text ?? "0") ?? 0
            print("\nSecond num = \(secondNumber)")
        } else {
            firstNumber =  Int(calculationLabel.text ?? "0") ?? 0
            calculationLabel.text = String(firstNumber) + String(sender.tag)
            firstNumber =  Int(calculationLabel.text ?? "0") ?? 0
            print("\nFirst num = \(firstNumber)")
        }
    }
   
    @IBAction func operationButtonTapped(_ sender: UIButton) {
            switch sender.tag {
            case 11: // equal
                if add == true {
                    calculationLabel.text = String(firstNumber) + "+" + String(secondNumber)
                    resultLabel.text = String(firstNumber + secondNumber)
                    add = false
                }
                if sub == true {
                    calculationLabel.text = String(firstNumber) + "-" + String(secondNumber)
                    resultLabel.text = String(firstNumber - secondNumber)
                    sub = false
                }
                if mult == true {
                    calculationLabel.text = String(firstNumber) + "*" + String(secondNumber)
                    resultLabel.text = String(firstNumber * secondNumber)
                    mult = false
                }
                if div == true {
                    calculationLabel.text = String(firstNumber) + "/" + String(secondNumber)
                    // 0/12 = inifinity
                    // 12/0 = arithmatic exception
                    if firstNumber == 0 {
                        let alertVC = UIAlertController(title: "Math Error", message: "Numerator can not be zero.", preferredStyle: .alert)
                        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alertVC, animated: true)
                        calculationLabel.text = ""
                        firstNumber = 0
                        secondNumber = 0
                    } else if secondNumber == 0 {
                        let alertVC = UIAlertController(title: "Math Error", message: "Can not divide by zero.", preferredStyle: .alert)
                        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alertVC, animated: true)
                        calculationLabel.text = ""
                        firstNumber = 0
                        secondNumber = 0
                    } else {
                        resultLabel.text = String(firstNumber / secondNumber)
                        div = false
                    }
            }
            case 13:  // addition
                isOperationBtnTapped = true
                add = true
            case 14:  // subtraction
                isOperationBtnTapped = true
                sub = true
            case 15:  // multiplication
                isOperationBtnTapped = true
                mult = true
            case 16:  // division
                isOperationBtnTapped = true
                div = true
            case 19: // clear
                calculationLabel.text = ""
                resultLabel.text = ""
                firstNumber = 0
                secondNumber = 0
                isOperationBtnTapped = false
            default:
                return
        }
    }
}

