//
//  ApiManager.swift
//  HeroList
//
//  Created by Jakub Majdl on 09.01.2023.
//

import Foundation
import RxSwift
import RxSwiftExt

protocol ApiManager {
    func characterList() -> Observable<CharacterList>
    func characterDetail(characterId: CharacterId) -> Observable<Character>
}

final class ApiManagerImpl: ApiManager {

    @Injected
    var configuration: AppConfiguration

    let jsonDecoder = JSONDecoder()

    //TODO: move the implementation to some other place?
    func characterList() -> Observable<CharacterList> {
        call(request: urlRequest(endpoint: "character"))
    }

    func characterDetail(characterId: CharacterId) -> Observable<Character> {
        call(request: urlRequest(endpoint: "character/\(characterId)"))
    }

    private func call<T: Decodable>(request: URLRequest) -> Observable<T> {
        return URLSession.shared.rx.data(request: request)
            .map { [weak self] data in
                guard let self else { throw RuntimeError("deallocated self") }

                return try self.jsonDecoder.decode(T.self, from: data)
            }
    }

    private func urlRequest(endpoint: String) -> URLRequest {
        guard var url = URL(string: configuration.apiBaseURL) else { fatalError("Error creating base api URL") }
        url.append(path: endpoint)
        url.append(queryItems: [.init(name: "api_key", value: configuration.apiKey)])

        return URLRequest(url: url)
    }

}
