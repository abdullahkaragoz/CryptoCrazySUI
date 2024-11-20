//
//  CryptoCrazySUIApp.swift
//  CryptoCrazySUI
//
//  Created by Abdullah Karagöz on 19.11.2024.
//

import SwiftUI

@main
struct CryptoCrazySUIApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(cryptoListViewModel: CryptoListViewModel())
        }
    }
}
