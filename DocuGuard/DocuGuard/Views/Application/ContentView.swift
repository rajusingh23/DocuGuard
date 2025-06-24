//
//  ContentView.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var err: String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 4) {
                        Image(.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.accentColor)

                        Text("Welcome to DocuGuard")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }

                    VStack(spacing: 16) {
                        
                        NavigationLink {
                            PDFViewerScreen()
                        } label: {
                            MenuButtonLabel(title: "View PDF Report", systemImage: "doc.richtext")
                        }
                        
                        NavigationLink {
                            ImagePickerScreen()
                        } label: {
                            MenuButtonLabel(title: "Select or Capture Image", systemImage: "photo.on.rectangle")
                        }
                        
                        NavigationLink {
                            APIObjectListView()
                        } label: {
                            MenuButtonLabel(title: "View API Objects", systemImage: "list.bullet.rectangle")
                        }


                        NavigationLink {
                            SettingsView()
                        } label: {
                            MenuButtonLabel(title: "Settings", systemImage: "gear")
                        }
                    }

                    Divider()

                    Button(role: .destructive) {
                        Task {
                            do {
                                try await AuthenticationView().logout()
                            } catch {
                                err = error.localizedDescription
                            }
                        }
                    } label: {
                        MenuButtonLabel(title: "Log Out", systemImage: "arrow.backward.circle.fill")
                    }

                    if !err.isEmpty {
                        Text(err)
                            .foregroundColor(.red)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .transition(.opacity)
                    }
                }
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}

struct MenuButtonLabel: View {
    let title: String
    let systemImage: String

    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .font(.title3)
            Text(title)
                .fontWeight(.medium)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    ContentView()
}
