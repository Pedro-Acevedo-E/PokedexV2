//
//  PokedexBordersView.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 04/06/24.
//

import SwiftUI

struct PokedexBordersView: View {
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.red)
                .containerRelativeFrame(.vertical, count: 15, span: 1, spacing: 0)
            Rectangle()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: 6)
            Spacer()
            Rectangle()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: 6)
            Rectangle()
                .foregroundColor(.red)
                .containerRelativeFrame(.vertical, count: 15, span: 1, spacing: 0)
        }
    }
}

#Preview {
    PokedexBordersView()
}
