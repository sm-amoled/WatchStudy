//
//  NetworkManager.swift
//  2_WeatherApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/07.
//

import Foundation

final class NetworkManager<T: Codable> {
    func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // error가 발생한 경우
            guard error == nil else {
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            
            // http Response Error가 발생한 경우
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.badResponse))
                return
            }
            
            // http status code가 잘못된 경우
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.wrongStatusCode(code: httpResponse.statusCode)))
                return
            }
            
            // Empty data인 경우
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                // decoding을 성공한 경우
                DispatchQueue.main.async {
                    completion(.success(json))
                }
            } catch let err {
                // decoding이 불가능한 경우
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case badResponse
    case wrongStatusCode(code: Int)
    case error(err: String)
    case decodingError(err: String)
    case emptyData
}
