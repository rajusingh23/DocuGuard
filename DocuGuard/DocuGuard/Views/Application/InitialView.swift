//
//  InitialView.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct InitialView: View {
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)

    var body: some View {
        VStack {
            if userLoggedIn {
                ContentView()
            } else {
                LogInView()
            }
        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { _, user in
                userLoggedIn = (user != nil)
            }
        }
    }
}

