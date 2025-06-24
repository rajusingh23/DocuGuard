//
//  PDFViewModel.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import Foundation

class PDFViewModel: ObservableObject {
    @Published var pdfURL: URL?
    
    init() {
        self.pdfURL = URL(string: "https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf")
    }
}
