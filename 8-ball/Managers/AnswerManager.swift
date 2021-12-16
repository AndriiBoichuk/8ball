//
//  AnswerManager.swift
//  8-ball
//
//  Created by Андрій Бойчук on 06.10.2021.
//

import Foundation
import RxSwift

struct AnswerManager {
    
    private enum FetchError: Error {
        case failedResponse(URLResponse?)
        case failedJSON(Error)
    }

    private let session = URLSession(configuration: .default)
    
    func getAnswer() -> Observable<Magic> {

        let urlString = "https://8ball.delegator.com/magic/JSON/Example"
        // Create URL
        let url = URL(string: urlString)!
        
        let request = URLRequest(url: url)
        return URLSession.shared.rx.response(request: request)
            .map { result -> Data in
                guard result.response.statusCode == 200 else {
                    throw FetchError.failedResponse(result.response)
                }
                return result.data
            }.map { data in
                if let answer = parseJSON(answerData: data) {
                    return answer
                } else {
                    return Magic(question: "", answer: "", type: "")
                }
            }
            .observe(on: MainScheduler.instance)
            .asObservable()
    }

    private func parseJSON(answerData: Data) -> Magic? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(AnswerData.self, from: answerData)
            let item = decodedData.magic
            return item
        } catch {
            return nil
        }
    }
    
}
