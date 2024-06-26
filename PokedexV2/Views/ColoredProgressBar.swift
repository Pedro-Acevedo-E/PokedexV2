//
//  ColoredProgressBar.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 21/06/24.
//

import SwiftUI

struct ColoredProgressBar: View {
    let value: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color.gray.opacity(0.2))
                .frame(maxWidth: .infinity, maxHeight: 10)
            
            Capsule()
                .fill(Color.blue)
                .frame(maxHeight: 10)
                .containerRelativeFrame(.horizontal, count: 280, span: value, spacing: 0)
        }
    }
}
