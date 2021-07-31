//
//  BitcoinManager.swift
//  Bitcoin
//
//  Created by MacBook on 29.07.2021.
//

import Foundation

// added protocol to delegate data from BitcoinManager to ViewController
protocol ManagerDelegate {
    func didUpdateCurrency(_ currency: Float, _ assetId: String)
}


struct BitcoinManager {
    
    // initialization a protocol in Manager struct
    var managerDelegate: ManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "2D07B19E-C6AC-46B9-9B07-11BBCE49F5C5"
    
    let currencyArray = ["UAH", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    // get chosen currency from VC to set full url string
    func getBitcoinPrice(_ currency: String) {
        let stringURL = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(stringURL)
    }
    
    
    func performRequest(_ urlString: String) {
        
        // unwrapping url to proceed further
        guard let url = URL(string: urlString) else {
            return
        }
        // create URL session, and pass url to session
        let session = URLSession(configuration: .default)
        
        // give a session a data task
        // set a closure to unwrap all off completionHandler data, interaction with dataTask
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            // unwraping error, and way out if error happens
            if error != nil {
                print(error ?? "error in handle method")
                return // set return to way out from handle method
            }
            // unwrapping data to convert Data to String further
            if let safeData = data {
                // to return information from parseJSON, created let rate
                self.parseJSON(safeData)
 
            }
        }
        
        // start the task (Resumes the task, if it is suspended)
        dataTask.resume()
    }
    
    func parseJSON(_ bitcoinData: Data) {
        // initialized decoder from JSONDecoder class
        let decoder = JSONDecoder()
        // interact with Decodable BitcoinData struct
        do {
            // assign WeatherData struct to let decodedData to get needed data
            let decodedData = try decoder.decode(BitcoinData.self, from: bitcoinData)
            
            // get data from rest.coinapi.io via BitcoinData
            let rate = decodedData.rate
            let asset_id_quote = decodedData.asset_id_quote
            print(rate)
            managerDelegate?.didUpdateCurrency(rate, asset_id_quote)
            
            
        } catch {
            print(error)

        }
   
    }
   
    
    
    
}
