//
//  Networkrequest.swift
//  sportzinteracttest
//
//  Created by AKSHAY VAIDYA on 15/11/2022 Saka.
//

import Foundation

class Networkrequest{
    
    static func getData(api:String ,completion:((DataModel?)->())? = nil){
        
        let url = URL(string: api)
        
        guard let url = url else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: {(data,_,_) in
            
            guard let jsondata = data,  let model = try? JSONDecoder().decode(DataModel.self, from: jsondata) else{
                completion?(nil)
                return
            }
            
            completion?(model)
            
        }).resume()
        
    }
    
}
