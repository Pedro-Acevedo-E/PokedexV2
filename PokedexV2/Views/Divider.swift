//
//  Divider.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 21/06/24.
//

import SwiftUI

struct Divider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.gray.opacity(0.3))
            .padding()
    }
}

#Preview {
    Divider()
}
