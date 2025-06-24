//
//  APIObjectFormView.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import SwiftUI

struct APIObjectFormView: View {
    @ObservedObject var viewModel: APIDataViewModel
    var object: CDAPIObject

    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var description: String = ""

    var body: some View {
        Form {
            Section(header: Text("Edit Object")) {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }

            Button("Update") {
                viewModel.update(item: object, newName: name, newDescription: description)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Edit Item")
        .onAppear {
            name = object.name ?? ""
            description = object.dataDescription ?? ""
        }
    }
}


