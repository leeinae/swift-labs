//
//  PokemonService.swift
//  swiftUI-labs
//
//  Created by Inae Lee on 11/9/23.
//

import Alamofire
import Combine
import Foundation

public enum NetworkError: Error {
    case serverError
    case parsingError
}

final class PokemonService {
    private let alamofire: Session

    public init(sesseion: Session) {
        alamofire = sesseion
    }

    func fetchPokemon(id: Int) -> AnyPublisher<PokemonResponse, Error> {
        let url = "https://pokeapi.co/api/v2/pokemon/\(id)"

        return alamofire
            .request(
                url,
                method: .get,
                parameters: nil,
                encoding: JSONEncoding.default
            )
            .validate(statusCode: 200 ..< 300)
            .publishData()
            .tryMap { response -> PokemonResponse in
                switch response.result {
                case let .success(data):
                    do {
                        return try
                            JSONDecoder().decode(PokemonResponse.self, from: data)
                    } catch {
                        throw NetworkError.parsingError
                    }
                case .failure:
                    throw NetworkError.serverError
                }
            }
            .eraseToAnyPublisher()
    }
}
