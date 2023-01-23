//
//  NetworkManager.swift
//  LondonFootballStadium
//
//  Created by Алексей Исаев on 23.01.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case invalidRequest
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init () {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchStadiumList(completion: @escaping(Result<Response, NetworkError>) -> Void) {
        var request = URLRequest(
            url: URL(string: "https://v3.football.api-sports.io/venues?city=london")!,
            timeoutInterval: 10.0)
        request.addValue("2d3297ddd732374c7f607d900b0d9c69", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v3.football.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            do {
                let stadiums = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(stadiums))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}



