//
//  Network.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import Foundation

class Network {
    
    static let shared = Network()
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()){
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error{
                print("Error fetching ", error)
                completion(nil, error)
                return
            }
        
            guard let data = data else {
                return completion(nil, nil)
            }
            
            do{
                let objects = try JSONDecoder().decode(T.self, from: data)
                print(objects)
                completion(objects,nil)
            } catch let jsonError{
                print("Error decode json ", jsonError)
                completion(nil, jsonError)
            }
        }.resume()
    }
}
