//
//  CryptoViewModel.swift
//  CryptoCrazySUI
//
//  Created by Abdullah Karagöz on 20.11.2024.
//

import Foundation


class CryptoListViewModel : ObservableObject  {
    
    @Published var cryptoList = [CryptoViewModel]()
    
    let webService = Webservice()
    
    func downloadCryptos(url : URL) {
        
        webService.getData(url: url) { result in
            
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let cryptos):
                DispatchQueue.main.async {
                    self.cryptoList = cryptos.map(CryptoViewModel.init)
                }
               
                
            }
        }
        
    }
    
    
}


struct CryptoViewModel {
    
    let crypto : CryptoCurrency
    
    var id : UUID? {
        crypto.id
    }
    
    var currency : String {
        crypto.currency
    }
    
    var price : String {
        crypto.price
    }
    
}
