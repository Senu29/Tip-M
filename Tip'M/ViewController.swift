//
//  ViewController.swift
//  Tip'M
//
//  Created by Senuda Ratnayake on 9/27/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    //@StateObject private var keyboardHandler = KeyBoardHandler()
    
    @IBOutlet weak var calculateTipBtn: UIButton!
    @IBOutlet weak var totalBillTextField: UITextField!
    
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var summaryUIView: UIView!
    @IBOutlet weak var tipPercentageSegmentControl: UISegmentedControl!
    @IBOutlet weak var summarytotalBillLabel: UILabel!
    @IBOutlet weak var tipAmountToPayLabel: UILabel!
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var splitTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        summaryUIView.layer.cornerRadius = 25.0
        tipPercentageSlider.setValue(5, animated: true)
        tipPercentageTextField.text = "5"
        splitTextField.text = "1"
        tipAmountToPayLabel.text = ""
        perPersonLabel.text = ""
        tipPercentageSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.systemBackground], for: .selected)
        print("center: \(self.view.center)\n")
 
        if(tipPercentageTextField.frame.origin.y > self.view.center.y){
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    func tipAmount() -> Float {
        var amount = 0.0
        let totBillAmount = (totalBillTextField.text! as NSString).floatValue
        let tipPercentage = (tipPercentageTextField.text! as NSString).floatValue
        
        amount = Double(((totBillAmount / 100) * tipPercentage))
        
        return Float(ceil(amount * 100) / 100.0)
    }
    
    func perAmount(tipValue: Float) -> Float {
        var amount = 0.0
        let totBillAmount = (totalBillTextField.text! as NSString).floatValue
        //let tipValue = tipAmount()
        let numPeople = (splitTextField.text! as NSString).floatValue
        
        amount = Double((totBillAmount + tipValue) / numPeople)
        
        return Float(ceil(amount * 100) / 100.0)
    }


    @IBAction func calcBtn(_ sender: Any) {
        if(totalBillTextField.text == nil){
            errorLabel.text = "Add the total Bill Amount"
            errorLabel.textColor = UIColor.red
        }
        let tip = tipAmount()

        let totBill = ((totalBillTextField.text! as NSString).floatValue) + tip
        
        summarytotalBillLabel.text = "$ " + "\(Float(ceil(totBill * 100) / 100.0))"
        
        tipAmountToPayLabel.text = "$ " + String(tip)
        perPersonLabel.text = "$ " + String(perAmount(tipValue: tip))
        self.view.endEditing(true) //dismiss the keyboard
    }
    
    @IBAction func tipSliderValueChanged(_ sender: UISlider) {
        let currentTipValue = Int(sender.value)
        tipPercentageTextField.text = "\(currentTipValue)"
        
        // matching the slider with the segment control.
        if(tipPercentageTextField.text == "5"){
            tipPercentageSegmentControl.selectedSegmentIndex = 0
        }else if(tipPercentageTextField.text == "10"){
            tipPercentageSegmentControl.selectedSegmentIndex = 1
        }else if(tipPercentageTextField.text == "15"){
            tipPercentageSegmentControl.selectedSegmentIndex = 2
        }else if(tipPercentageTextField.text == "35"){
            tipPercentageSegmentControl.selectedSegmentIndex = 3
        }else if(tipPercentageTextField.text == "75"){
            tipPercentageSegmentControl.selectedSegmentIndex = 4
        }else{
            tipPercentageSegmentControl.selectedSegmentIndex = 5
        }
    }
    
    @IBAction func tipSegmentChanged(_ sender: Any) {
        switch tipPercentageSegmentControl.selectedSegmentIndex{
        case 0:
            tipPercentageTextField.text = "5"
            tipPercentageSegmentControl.setTitleTextAttributes([.foregroundColor:UIColor.systemBackground], for: .selected)
            tipPercentageSlider.setValue(5.0, animated: true)
        case 1:
            tipPercentageTextField.text = "10"
            tipPercentageSegmentControl.setTitleTextAttributes([.foregroundColor:UIColor.systemBackground], for: .selected)
            tipPercentageSlider.setValue(10.0, animated: true)
        case 2:
            tipPercentageTextField.text = "15"
            tipPercentageSegmentControl.setTitleTextAttributes([.foregroundColor:UIColor.systemBackground], for: .selected)
            tipPercentageSlider.setValue(15.0, animated: true)
        case 3:
            tipPercentageTextField.text = "35"
            tipPercentageSegmentControl.setTitleTextAttributes([.foregroundColor:UIColor.systemBackground], for: .selected)
            tipPercentageSlider.setValue(35.0, animated: true)
        case 4:
            tipPercentageTextField.text = "75"
            tipPercentageSegmentControl.setTitleTextAttributes([.foregroundColor:UIColor.systemBackground], for: .selected)
            tipPercentageSlider.setValue(75.0, animated: true)
        default:
            break
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard
        totalBillTextField.resignFirstResponder();
        tipPercentageTextField.resignFirstResponder();
        splitTextField.resignFirstResponder();
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        // move the root view up by the distance of keyboard height
        self.view.frame.origin.y = 0 - keyboardSize.height
        
        
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
}


