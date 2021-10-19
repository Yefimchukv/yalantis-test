//
//  NetworkService.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    
    private let endpoint = "https://8ball.delegator.com/magic/JSON/_"
    
    private init() {}
    
    func getAnswer(completion: @escaping (Result<Answer, YTError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.urlError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.internetIssue))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.internetIssue))
                return
            }
            
            guard let data = data else {
                completion(.failure(.internetIssue))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let answer = try decoder.decode(Answer.self, from: data)
                completion(.success(answer))
            } catch {
                print(error)
                completion(.failure(.decodeError))
            }
        }
        task.resume()
    }
}
