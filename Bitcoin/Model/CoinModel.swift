//
//  CoinModel.swift
//  Bitcoin
//
//  Created by Tatyana Sidoryuk on 11.08.2022.
//

import Foundation

struct CoinModel {

    let rate: Double
    let currency: String
    
    var rateString: String {
        return String(format: "%.1f", rate)
    }
}
