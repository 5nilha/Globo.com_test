//
//  Dataservices.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation
import Alamofire

class Webservices {
    
    static func fetchFilmes(completion: @escaping ([FilmeViewModel]?) -> ()) {
        guard let url = URL(string: "https://my-json-server.typicode.com/5nilha/Globo.com_test/db") else {
            completion(nil)
            return
        }
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            let result = response.result
            if !result.isSuccess {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                completion(nil)
                return
            }
            guard let value = result.value as? [String : Any], let filmesData = value["filmes"] as? [[String : Any]] else {
                completion(nil)
                return
            }
            print(filmesData)
            var filmes = [FilmeViewModel]()
            for filmeDic in filmesData {
                let filme = FilmeViewModel(filmeJSON: filmeDic)
                if filme != nil {
                    filmes.append(filme!)
                }
            }
            filmes.sort { (a, b) -> Bool in
                return a.title < b.title
            }
            completion(filmes)
            
        }
    }
    
    
    func deleteRealmAuthentication(token: String) {
        guard let url = URL(string: "http://my-ros-instance:9080/auth/user/:user_id") else {
            return
        }
        
        let userToken = token
        let headers = ["Authorization": userToken]
        
        Alamofire.request(url, method: .delete, headers: headers).responseJSON { (response) in
            print(response.result)
        }
    }
}
