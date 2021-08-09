//
//  APIManager.swift
//  IOS3_COVID_FINAL
//
//  Created by Marlon Machado on 08/08/21.
//

import Foundation
import Alamofire

class APIManager {
    static let endpoint = "https://elastic-leitos.saude.gov.br/leito_ocupacao/_search"
    
    static private func getHeaders () -> HTTPHeaders{
        let credentialData = "user-api-leitos:aQbLL3ZStaTr38tj".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        return ["Authorization": "Basic \(base64Credentials)"]
    }
    
    static private func getParameters() -> [String: Any]{
        return  [
            "size" : 5000
        ]
    }
    
    static func callAPI(onCompletionHandler : @escaping (CovidModel?) -> Void) {
        AF.request(endpoint, method: .get, parameters: getParameters(), headers: getHeaders()).responseJSON { (json) in
            switch json.result {
            case .success:
                if let jsonData = json.data {
                    let jsonDecoder = JSONDecoder()
                    let dado = try! jsonDecoder.decode(CovidModel.self, from: jsonData)
                    onCompletionHandler(dado)
                } else {
                    onCompletionHandler(nil)
                }
                break
            case .failure:
                onCompletionHandler(nil)
                break
            }
        }
    }
}
