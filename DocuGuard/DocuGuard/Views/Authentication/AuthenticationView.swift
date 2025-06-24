//
//  AuthenticationView.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn

class AuthenticationView: ObservableObject{
    @Published var isLoginSuccessed = false
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        let rootViewController = Application_utility.rootViewController


        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                print("Google Sign-In error: \(error)")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Google Sign-In failed to retrieve user or token")
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Auth error: \(error.localizedDescription)")
                    return
                }

                if let currentUser = Auth.auth().currentUser {
                    let name = currentUser.displayName ?? "No Name"
                    let email = currentUser.email ?? "No Email"

                    DispatchQueue.main.async {
                        CoreDataManager.shared.saveUser(name: name, email: email)
                    }
                }
            }
        }
    }
    
    func logout() async throws{
        GIDSignIn.sharedInstance.signOut()
        try Auth.auth().signOut()
    }
   
}
