//
//  CoinManager.swift
//  Bitcoin
//
//  Created by Tatyana Sidoryuk on 08.08.2022.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateBitcoin (_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError (error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "A873A362-6E3C-4DB2-947C-914622B81A5F"
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice (for currency: String) {
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func performRequest (with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession (configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let coin = self.parseJSON(safeData) {
                        self.delegate?.didUpdateBitcoin(self, coin: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON (_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)

            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            
            let thisRate = CoinModel(rate: rate, currency: currency)
            return thisRate
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
