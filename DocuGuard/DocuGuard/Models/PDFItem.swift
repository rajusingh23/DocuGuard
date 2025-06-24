//
//  PDFItem.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import Foundation

struct PDFItem: Identifiable {
    let id = UUID()
    let title: String
    let url: URL
}
