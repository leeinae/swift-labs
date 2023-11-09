//
//  PokemonViewModel.swift
//  swiftUI-labs
//
//  Created by Inae Lee on 11/9/23.
//

import Combine

class PokemonViewModel: ObservableObject {
    init() {
        service = PokemonService(sesseion: .default)
    }

    @Published var pokemons: [Pokemon] = []

    func fetchPokemon(id: Int) {
        service.fetchPokemon(id: id)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] response in
                let pokemon = response.convertToModel()
                self?.pokemons.append(pokemon)
            }
            .store(in: &cancellables)
    }

    private let service: PokemonService
    private var cancellables: Set<AnyCancellable> = []
}
