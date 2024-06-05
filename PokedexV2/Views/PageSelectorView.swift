//
//  PageSelectorView.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 05/06/24.
//

import SwiftUI

struct PageSelectorView: View {
    @Binding var page: Int
    let pages: Int
    
    var body: some View {
        HStack {
            Button {
                if(page > 0) {
                    page -= 1
                }
            } label: {
                Text("<")
            }
            Picker("Select Page", selection: $page) {
                ForEach(0...pages, id: \.self) {
                    Text($0 + 1, format: .number)
                }
            }
            .pickerStyle(.menu)
            Button {
                if (page < pages) {
                    page += 1
                }
            } label: {
                Text(">")
            }
        }
    }
}

#Preview {
    PageSelectorView(page: .constant(0), pages: 20)
}
