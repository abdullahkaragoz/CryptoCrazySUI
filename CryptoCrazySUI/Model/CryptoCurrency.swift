//
//  CryptoCurrency.swift
//  CryptoCrazySUI
//
//  Created by Abdullah Karagöz on 19.11.2024.
//

import Foundation


struct CryptoCurrency : Decodable, Identifiable {
    var id = UUID()
    let currency : String
    let price : String
    
    private enum CodingKeys : String, CodingKey {
        case currency
        case price
    }
}

