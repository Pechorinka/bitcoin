//
//  CoinData.swift
//  Bitcoin
//
//  Created by Tatyana Sidoryuk on 11.08.2022.
//

import Foundation

struct CoinData: Codable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
