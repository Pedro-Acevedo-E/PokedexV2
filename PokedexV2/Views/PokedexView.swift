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
    
    var body: some View {
        VStack {
            ScrollView {
                Rectangle()
                    .foregroundColor(.black.opacity(0))
                    .containerRelativeFrame(.vertical, count: 15, span: 1, spacing: 0)
                LazyVGrid(columns: columns) {
                    ForEach(pokedex.entries) { i in
                        ZStack {
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [i.color, i.color.opacity(0.4)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 180, height: 180)
                            VStack {
                                AsyncImage(url: URL(string: i.image)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 90, height: 90)
                                    case .success(let image):
                                        image.resizable()
                                            .frame(width: 90, height: 90)
                                    case .failure:
                                        Image(systemName: "questionmark")
                                    @unknown default:
                                        Image(systemName: "questionmark")
                                    }
                                }
                                Text(i.name)
                                HStack {
                                    ForEach(i.pokemonForms.first?.types ?? []) { type in
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 25)
                                                .fill(type.color)
                                                .stroke(.white, lineWidth: 1)
                                                .frame(width: 80, height: 30)
                                            Text(type.pokemonType.name)
                                        }
                                    }
                                }
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                }
                Rectangle()
                    .foregroundColor(.black.opacity(0))
                    .containerRelativeFrame(.vertical, count: 15, span: 1, spacing: 0)
            }
        }
        .task {
            await pokedex.loadData(page: 0)
        }
    }
}

#Preview {
    PokedexView()
}
