//
//  PokedexView.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 04/06/24.
//

import SwiftUI

struct PokedexView: View {
    @State private var pokedex = PokedexViewModel()
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 180))
    ]
    @State private var page = 0
    
    var body: some View {
        VStack {
            ScrollView {
                Rectangle()
                    .foregroundColor(.black.opacity(0))
                    .containerRelativeFrame(.vertical, count: 15, span: 1, spacing: 0)
                LazyVGrid(columns: columns) {
                    ForEach(pokedex.entries) { i in
                        PokedexCellView(entry: i)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                }
                PageSelectorView(page: $page, pages: pokedex.pages)
                Rectangle()
                    .foregroundColor(.black.opacity(0))
                    .containerRelativeFrame(.vertical, count: 15, span: 1, spacing: 0)
            }
        }
        .task {
            await pokedex.loadData(page: page)
            await pokedex.loadPokedexCount()
        }
        .onChange(of: page) {
            Task.detached(priority: .background) {
                await pokedex.loadData(page: page)
            }
        }
    }
}

#Preview {
    PokedexView()
}
