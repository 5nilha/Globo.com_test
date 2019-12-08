//
//  Dataservices.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
    
}

class Webservices {
    
    static func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> () ) {
        
        //Creates the URL request, methods and body for http request
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Starts the URL section
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.domainError))
            }
            guard let data = data else {
                completion(.failure(.domainError))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    static func loadJson(completion: @escaping (Result<[String : Any], Error>) -> ()) {
        if let path = Bundle.main.path(forResource: "filmes", ofType: "json") {
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)

                
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    completion(.success(jsonResult))
                }
             
            } catch {
               
                return
            }
            
            
        }
    }
    
}
