//
//  Webservice.swift
//  CryptoCrazySUI
//
//  Created by Abdullah Karagöz on 19.11.2024.
//

import Foundation


class Webservice {
    
    func downloadCurrenciesContinuation(url: URL) async throws -> [CryptoCurrency] {

        try await withCheckedContinuation { continuation in
            getData(url: url) { result in
                switch result {
                  case .success(let cryptos):
                    continuation.resume(returning: cryptos)
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    /*
    func downloadCurrenciesAsync(url: URL) async throws -> [CryptoCurrency] {
         
        let (data, _) = try await URLSession.shared.data(from: url)
         
         let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
         
         return currencies ?? []
     }
    */
    
    
    func getData( url: URL, completion: @escaping (Result<[CryptoCurrency], DownloadError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(.invalidURL))
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyResponse))
                return
            }
            
            do {
                let currencies = try JSONDecoder().decode([CryptoCurrency].self, from: data)
                completion(.success(currencies))
            } catch {
                print("Decoding Error: \(error.localizedDescription)")
                completion(.failure(.decodingFailed))
            }
            
        }.resume()
    }
    
    
    enum DownloadError: Error {
        case invalidURL       
        case emptyResponse
        case decodingFailed
        
        var localizedDescription: String {
            switch self {
            case .invalidURL:
                return "The provided URL is invalid."
            case .emptyResponse:
                return "No data was received from the server."
            case .decodingFailed:
                return "The data could not be decoded successfully."
            }
        }
    }
}
