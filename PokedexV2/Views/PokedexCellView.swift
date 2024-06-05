//
//  PokedexCellView.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 05/06/24.
//

import SwiftUI

struct PokedexCellView: View {
    let entry: PokedexEntry
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [entry.color, entry.color.opacity(0.4)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 180, height: 180)
            VStack {
                AsyncImage(url: URL(string: entry.image)) { phase in
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
                Text(entry.name)
                HStack {
                    ForEach(entry.pokemonForms.first?.types ?? []) { type in
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
    }
}

#Preview {
    PokedexCellView(entry: PokedexEntry(id: 1, name: "Bulbasaur", pokemonForms: []))
}
