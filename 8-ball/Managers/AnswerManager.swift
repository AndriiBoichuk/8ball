//
//  AnswerManager.swift
//  8-ball
//
//  Created by Андрій Бойчук on 06.10.2021.
//

import Foundation

struct AnswerManager {

    private let session = URLSession(configuration: .default)
    
    func getAnswer(completion: @escaping (Magic?, Error?) -> Void) {

        let urlString = "https://8ball.delegator.com/magic/JSON/Example"
        // Create URL
        let url = URL(string: urlString)!
        
        // Give the session a task
        let task = session.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(nil, error)
            }
            if let safeData = data {
                if let item = parseJSON(answerData: safeData) {
                    DispatchQueue.main.async {
                        completion(item, nil)
                    }
                } else {
                    completion(nil, nil)
                }
            }
        }
        // Start the task
        task.resume()
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
