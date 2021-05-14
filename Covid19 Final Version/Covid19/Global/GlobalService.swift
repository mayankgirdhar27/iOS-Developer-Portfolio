//
//  GlobalService.swift
//  Covid19
//
//  Created by Mayank Girdhar on 16/08/20.
//

import Foundation

class GlobalService {
    
    func getGlobal(completion: @escaping (Global?) -> ()) {
        
        guard let url = URL(string: "https://api.covid19api.com/summary") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let globalResponse = try? JSONDecoder().decode(GlobalResponse.self, from: data)
            if let globalResponse = globalResponse {
                let global = globalResponse.Global
                completion(global)
            } else {
                completion(nil)
            }
            
        }.resume()
        
    }
}


