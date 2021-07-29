//
//  BitcoinManager.swift
//  Bitcoin
//
//  Created by MacBook on 29.07.2021.
//

import Foundation

struct BitcoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY_HERE"
    
    let currencyArray = ["UAH", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    // added function to get selected data of row from ViewController
    func getBitcoinPrice(_ currency: String) {
        print("selected currency is \(currency)")
    }
}
