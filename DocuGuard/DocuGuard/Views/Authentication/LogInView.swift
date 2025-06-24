//
//  LogInView.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import SwiftUI
import Firebase
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct LogInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loginError = ""
    @State private var isLoggedIn = false
    @State private var isLoading = false
    private let vm = AuthenticationView()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 4) {
                    Image(.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.accentColor)
                    Text("Welcome to DocuGuard")
                        .font(.title2)
                        .fontWeight(.semibold)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("Enter your email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                }

                if !loginError.isEmpty {
                    Text(loginError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .transition(.opacity)
                }

                Button(action: login) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(width: 200, height: 50)
                    } else {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .background(email.isEmpty || password.isEmpty ? Color.gray : Color.accentColor)
                .cornerRadius(10)
                .disabled(email.isEmpty || password.isEmpty || isLoading)

                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.3))
                    Text("OR")
                        .foregroundColor(.gray)
                        .font(.caption)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.3))
                }

                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light)) {
                    vm.signInWithGoogle()
                }

                Spacer()
            }
            .padding()
            .animation(.easeInOut, value: loginError)
            .navigationDestination(isPresented: $isLoggedIn) {
                ContentView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }

    func login() {
        loginError = ""
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            isLoading = false
            if let error = error {
                loginError = error.localizedDescription
            } else {
                isLoggedIn = true
            }
        }
    }
}

#Preview {
    LogInView()
}
