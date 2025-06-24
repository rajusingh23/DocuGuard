//
//  PDFViewerScreen.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import SwiftUI

struct PDFViewerScreen: View {
    @StateObject private var viewModel = PDFViewModel()

    var body: some View {
        Group {
            if let url = viewModel.pdfURL {
                PDFKitView(url: url)
            } else {
                ProgressView("Loading PDF...")
            }
        }
        .navigationTitle("PDF Report")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    PDFViewerScreen()
}
