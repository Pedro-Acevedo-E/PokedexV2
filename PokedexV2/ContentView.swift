//
//  ContentView.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 30/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            PokedexBackgroundView()
            PokedexView()
            PokedexBordersView()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
