//
//  PokemonView.swift
//  swiftUI-labs
//
//  Created by Inae Lee on 11/9/23.
//

import Kingfisher
import SwiftUI

struct PokemonView: View {
    @ObservedObject var viewModel = PokemonViewModel()

    var body: some View {
        List {
            ForEach(viewModel.pokemons, id: \.id) { pokemon in
                VStack(alignment: .center, spacing: 8) {
                    KFImage(pokemon.imageURL!)
                        .resizable()
                        .frame(height: UIScreen.main.bounds.width)
                        .shadow(radius: 12)
                        .cornerRadius(12)

                    HStack {
                        Text("No.\(pokemon.id)")
                            .font(.subheadline)
                        Text(pokemon.name)
                            .font(.headline)
                    }
                    .foregroundStyle(Color.gray)
                    .lineLimit(1)
                    .truncationMode(.tail)

                    if let stat = pokemon.stat {
                        Text("Stat: \(stat)")
                    }
                    if let type = pokemon.type {
                        Text("Type: \(type)")
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            (0 ... 10).forEach {
                self.viewModel.fetchPokemon(id: $0)
            }
        }
    }
}

#Preview {
    PokemonView()
}
