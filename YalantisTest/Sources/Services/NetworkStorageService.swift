//
//  NetworkService.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 18.10.2021.
//

import Foundation
import RxSwift

// class NetworkStorageService: AnswerProviderProtocol {
class NetworkStorageService: AnswerProviderProtocol {
    
    private let endpoint = "https://8ball.delegator.com/magic/JSON/_"
    
    func loadAnswer() -> Observable<ManagedAnswer> {
        
        return Observable.create { observer in
            
            guard let url = URL(string: self.endpoint) else {
                observer.onError(YTError.urlError)
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    observer.onError(YTError.urlError)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    observer.onError(YTError.internetIssue)
                    return
                }
                
                guard let data = data else {
                    observer.onError(YTError.internetIssue)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let answer = try decoder.decode(ManagedAnswer.self, from: data)
                    observer.onNext(answer)
                } catch {
                    observer.onError(YTError.decodeError)
                    print(error)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
