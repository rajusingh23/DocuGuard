//
//  APIObjectListView.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import SwiftUI

struct APIObjectListView: View {
    @StateObject private var viewModel = APIDataViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items, id: \.self) { item in
                    NavigationLink(destination: APIObjectFormView(viewModel: viewModel, object: item)) {
                        VStack(alignment: .leading) {
                            Text(item.name ?? "")
                                .font(.headline)
                            Text(item.dataDescription ?? "")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Stored Objects")
            .onAppear {
                Task {
                    await viewModel.fetchFromAPI()
                }
            }
        }
    }

    func deleteItems(at offsets: IndexSet) {
        offsets.forEach { index in
            let item = viewModel.items[index]
            viewModel.delete(item)
        }
    }
}

#Preview {
    APIObjectListView()
}
