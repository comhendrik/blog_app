//
//  LoginViewModel.swift
//  APICall
//
//  Created by Hendrik Steen on 09.02.22.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var alertMsg = ""
    @Published var showAlert = false
    @AppStorage("main_account_username") var mainAccountUsername = ""
    @AppStorage("main_account_id") var mainAccountID = 0
    
    func signUp() {
        //Es wird ein POST request mit username und password gestartet
        postFunction(urlToUse: URL(string: "http://127.0.0.1:5000/app/auth/register"),
                     bodyToUse: ["username": username,"password": password] as Dictionary<String,String>,
                     completionHandler: {response, err in
            if err != nil {
                //Bei einem error wird ein Alert aufgerufen
                DispatchQueue.main.async {
                    self.alertMsg = err!
                    print(self.alertMsg)
                    self.showAlert.toggle()
                }
            } else {
                //Bei erfolgreichem Abschluss des Registrationsvorgangs wird ebenfalls ein Alert aufgerufen
                DispatchQueue.main.async {
                    self.alertMsg = "Succesfully registered. Please press the login button"
                    print(response!)
                    self.showAlert.toggle()
                }
            }
        })
    }
    

    
    func signIn() {
        //Es wird ein POST request mit username und password gestartet.
        postFunction(urlToUse: URL(string: "http://127.0.0.1:5000/app/auth/login"),
                     bodyToUse: ["username": username,"password": password] as Dictionary<String,String>,
                     completionHandler: { response, err in
            
            if err != nil {
                //Bei einem error wird ein Alert aufgerufen
                DispatchQueue.main.async {
                    self.alertMsg = err!
                    print(self.alertMsg)
                    self.showAlert.toggle()
                }
            } else if response != nil {
                //Ist der Request erfolgreich können wir die Daten für den Mainaccount übergeben
                DispatchQueue.main.async {
                    self.mainAccountID = response!["id"] as? Int ?? 0
                    self.mainAccountUsername = response!["username"] as? String ?? "no user"
                    self.alertMsg = "Succesfully logged in"
                    self.showAlert.toggle()
                }
            } else {
                DispatchQueue.main.async {
                    self.alertMsg = "Problems with sign in."
                    self.showAlert.toggle()
                }
            }
        })
    }
    
    func logOut() {
        self.mainAccountID = 0
        self.mainAccountUsername = ""
    }
}
