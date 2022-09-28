//
//  ViewController.swift
//  Tip'M
//
//  Created by Senuda Ratnayake on 9/27/22.
//

import UIKit

class ViewController: UIViewController {
    
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

        let totBill = (totalBillTextField.text! as NSString).floatValue
        summarytotalBillLabel.text = "$ " + "\(totBill + tip)"
        
        tipAmountToPayLabel.text = "$ " + String(tip)
        perPersonLabel.text = "$ " + String(perAmount(tipValue: tip))
        
    }
    
    @IBAction func tipSliderValueChanged(_ sender: UISlider) {
        let currentTipValue = Int(sender.value)
        tipPercentageTextField.text = "\(currentTipValue)"
        tipPercentageSegmentControl.selectedSegmentIndex = 4
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
    
        
    
}

