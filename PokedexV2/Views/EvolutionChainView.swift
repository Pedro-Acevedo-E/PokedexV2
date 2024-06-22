//
//  EvolutionChainView.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 21/06/24.
//

import SwiftUI

struct EvolutionChainView: View {
    @State private var width: CGFloat?
    let chain: [Chain]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(chain) { pkm in
                    VStack {
                        AsyncImage(url: pkm.imageURL ?? URL(string: "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 90, height: 90)
                            case .success(let image):
                                image.resizable().scaledToFit()
                                    .frame(width: 90, height: 90)
                            case .failure:
                                Image(systemName: "questionmark")
                            @unknown default:
                                Image(systemName: "questionmark")
                            }
                        }
                        Text(pkm.species.name ?? "")
                    }
                }
            }
            .frame(minWidth: width)
        }
        .widthReader { width in
            self.width = width
        }
    }
}

