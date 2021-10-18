//
//  AnswerManager.swift
//  8-ball
//
//  Created by Андрій Бойчук on 06.10.2021.
//

import Foundation

protocol AnswerDelegateProtocol {
    func responseReceived(answer: String)
    func didFailWithError(error: Error)
}

struct AnswerManager {
    
    var delegate: ViewController?
    
    func getAnswer(for word: String) {
        let url = "https://8ball.delegator.com/magic/JSON/\(word)"
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String) {
        
        // Create URL
        let url = URL(string: urlString)!
        
        // Create a URLSession
        let session = URLSession(configuration: .default)
        
        // Give the session a task
        let task = session.dataTask(with: url) { data, resopnse, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
            }
            if let safeData = data {
                if let title = parseJSON(answerData: safeData) {
                    DispatchQueue.main.async {
                        delegate?.responseReceived(answer: title)
                    }
                }
            }
        }
        // Start the task
        task.resume()
    }
    
    func parseJSON(answerData: Data) -> String? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(AnswerData.self, from: answerData)
            let title = decodedData.magic.answer
            
            return title
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
