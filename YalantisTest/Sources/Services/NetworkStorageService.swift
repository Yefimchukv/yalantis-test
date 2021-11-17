//
//  NetworkService.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import Foundation

class NetworkStorageService: AnswerProviderProtocol {
    
    private let endpoint = "https://8ball.delegator.com/magic/JSON/_"
    
    private let decoder = JSONDecoder()

    func loadAnswer() async throws -> ManagedAnswer {
        guard let url = URL(string: endpoint) else {
            throw YTError.internetIssue
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw YTError.internetIssue
        }
        
        do {
            return try decoder.decode(ManagedAnswer.self, from: data)
        } catch {
            throw YTError.decodeError
        }
    }
}
