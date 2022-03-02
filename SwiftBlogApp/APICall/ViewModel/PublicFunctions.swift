//
//  PublicFunctions.swift
//  APICall
//
//  Created by Hendrik Steen on 10.02.22.
//

import Foundation



public func postFunction(urlToUse : URL?, bodyToUse: Dictionary<String, Any>, completionHandler: @escaping (Dictionary<String, Any>?, String?) -> Void){
    //Diese Funktion startet einen POST Request mit der angegebenen URL. Ein httpBody muss übergeben werden.
    guard let url = urlToUse else {
        completionHandler(nil, "Problems with accessing the url")
        return
    }
    
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    
    let body = bodyToUse
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request)  { data, _, err in
         guard let data = data, err == nil else {
             completionHandler(nil, err!.localizedDescription)
              return
         }
        
         do {
             let res = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as! [String: Any]
             //Der completion handler kann einen Fehler, sowie eine Antwort empfangen.
             //In diesem Fall hat alles geklapt und eine Antwort wird über den completionHandler weiter verwaltet
             completionHandler(res, nil)
         } catch {
             //Sollte es einen Fehler geben wird die Antwort decoded und per completionHandler weiter verwaltet
             completionHandler(nil, String(decoding: data, as: UTF8.self))
         }
        
    }
    task.resume()
}
