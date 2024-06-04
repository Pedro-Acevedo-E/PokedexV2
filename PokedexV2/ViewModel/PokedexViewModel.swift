//
//  PokedexViewModel.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 04/06/24.
//

import Foundation

extension PokedexView {
    @Observable
    class PokedexViewModel {
        var entries: [PokedexEntry] = []
        
        func loadData(page: Int) async {
            let url = URL(string: graphQLBaseURL)!
            let query = buildQuery(offset: page)
            
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: ["query": query, "variables": nil], options: [])
            
            do {
                let response = try await URLSession.shared.data(for: request)
                let decodedPokedex = try JSONDecoder().decode(PokedexData.self, from: response.0)
                entries = decodedPokedex.data.pokedexEntries
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
