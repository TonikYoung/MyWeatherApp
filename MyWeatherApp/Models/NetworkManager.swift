//
//  NetworkManager.swift
//  MyWeatherApp
//
//  Created by abramovanto on 29.05.2024.
//

import Foundation

struct NetworkManager {
    func get<T: Decodable>(scheme: String, host: String, path: String, params: [String: String], completion: @escaping (Result<T, Error>) -> Void) {
        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data!)
                    completion(.success(result))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }
        .resume()
    }
}
