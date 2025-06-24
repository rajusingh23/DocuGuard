//
//  SettingsView.swift
//  DocuGuard
//
//  Created by Raju Singh on 22/06/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = true

    var body: some View {
        Form {
            Section(header: Text("Preferences")) {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
            }

            Section {
                Text("Version 1.0.0")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
