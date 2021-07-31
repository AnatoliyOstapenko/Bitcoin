//
//  ViewController.swift
//  Bitcoin
//
//  Created by MacBook on 29.07.2021.
//

import UIKit



class ViewController: UIViewController {
    
    // initializated BitcoinManager
    var bitcoinManager = BitcoinManager()

    
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the ViewController class as the datasource to currencyPicker object.
        currencyPicker.dataSource = self
        
        // set the ViewController class as the delegate of the currencyPicker
        currencyPicker.delegate = self
        
        // set the ViewController class as the delegate of the managerDelegate
        bitcoinManager.managerDelegate = self
    }

   
    
    
    
}

// added extension with protocol UIPickerViewDataSource to activate pickerView
extension ViewController: UIPickerViewDataSource {
    
    // set 1 column
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // set quantity of rows is equal quantity in array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bitcoinManager.currencyArray.count
    }
    
 
    
}
// added extension with protocol UIPickerViewDataSource to delegate pickerView
extension ViewController: UIPickerViewAccessibilityDelegate {
    // picked the title from currencyArray
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
 
        // return current row in array
        return bitcoinManager.currencyArray[row]
       
    }
    // picked row by user
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // dispatch selected data row to BitcoinManager struct
        let selectedRow = bitcoinManager.currencyArray[row]
        bitcoinManager.getBitcoinPrice(selectedRow)
    }

    
}

// extension to receive data delegated from Manager struct
extension ViewController: ManagerDelegate {
    func didUpdateCurrency(_ currency: Float, _ assetId: String) {
        
        // Dispatch Queue to avoid frozen app state mandatory
        DispatchQueue.main.async { [self] in
            sumLabel.text = String(format: "%.2f", currency) // transmitted currency from BitconManager
            currencyLabel.text = assetId                     // transmitted asset id from BitconManager
        }
    }
   
}
