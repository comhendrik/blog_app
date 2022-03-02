//
//  PostViewModel.swift
//  APICall
//
//  Created by Hendrik Steen on 10.02.22.
//

import Foundation
import SwiftUI

struct BlogPost: Codable, Identifiable {
    var id: Int
    var title: String
    var body: String
    var user: String
    
    enum CodingKeys: String, CodingKey {
         case id = "id"
         case title = "title"
         case body = "body"
         case user = "user"
    }
}

class PostViewModel: ObservableObject {
    @Published var allBlogPosts = [BlogPost]()
    @Published var blogPostTitle = ""
    @Published var blogPostBody = ""
    @Published var alertMsg = ""
    @Published var showAlert = false
    @Published var searchText = ""
    
    init() {
        getAllBlogPosts { blogposts in
            DispatchQueue.main.async {
                self.allBlogPosts = blogposts
            }
        }
    }
    
    func getAllBlogPosts(completion: @escaping ([BlogPost]) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/app/post/all_post") else {
           return
       }
       //Mit Url session werden die Daten abgerufen
       let task = URLSession.shared.dataTask(with: url) { data, _, err in
           if err != nil {
              print(err!)
           }
           else if let data = data {
               //Die Api gibt eine Antwort in Form von einer Json Datei
               do {
                   //Diese Antwort wird als BlogPost decoded und danach aufgrund der id sortiert, sodass der neueste Post ganz vorne ist.
                   var result = try JSONDecoder().decode([BlogPost].self, from: data)
                   result = result.sorted(by: { $0.id > $1.id })
                   completion(result)
               }
               catch {
                   print(error)
               }
           }
       }
       
       task.resume()
    }
    
    func createPost(with username: String?) {
        postFunction(urlToUse: URL(string: "http://127.0.0.1:5000/app/post/create_post"),
                     bodyToUse: ["username": username as Any,
                                 "title": blogPostTitle,
                                 "body": blogPostBody]) { response, err in
            if err != nil {
                //Bei einem error wird ein Alert aufgerufen
                DispatchQueue.main.async {
                    self.alertMsg = err!
                    print(self.alertMsg)
                    self.showAlert.toggle()
                }
            } else {
                //Bei erfolgreichem Abschluss des Erstellungsvorgang wird ebenfalls ein Alert aufgerufen und anstatt alle BlogPost neu zu laden, wird ein neuer innerhalb der App aufgrund der Antwort erstellt und dem Array hinzugefügt.
                DispatchQueue.main.async {
                    print(response!)
                    self.allBlogPosts.insert(BlogPost(id: (response!["post_id"] as! NSString).integerValue, title: response!["title"] as! String, body: response!["body"] as! String, user: response!["username"] as! String), at: 0)
                    self.alertMsg = "Succesfully posted"
                    self.showAlert.toggle()
                }
            }
        }
    }
}
