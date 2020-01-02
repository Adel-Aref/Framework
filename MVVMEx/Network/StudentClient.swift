//
//  StudentClient.swift
//  MVVMEx
//
//  Created by User on 12/15/19.
//  Copyright © 2019 Adel. All rights reserved.
//

import Foundation
class StudentClient :APIClient {
    func getStudents( completion: @escaping (RequestResult<Decodable, RequestError>) -> Void){
        guard let url = Endpoint.student().url else { return }
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //urlRequest.httpMethod = HTTPMethod.post.rawValue
        makeRequest(withRequest: urlRequest ,decodingType: Students.self) { (result) in
            completion(result)
        }
    }
}
