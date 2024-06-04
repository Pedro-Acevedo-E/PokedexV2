//
//  PokedexBackground.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 04/06/24.
//

import SwiftUI

struct PokedexBackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.blue, .white]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#Preview {
    PokedexBackgroundView()
}
