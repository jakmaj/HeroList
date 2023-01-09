//
//  ApiManager.swift
//  HeroList
//
//  Created by Jakub Majdl on 09.01.2023.
//

import Foundation
import RxSwift
import RxSwiftExt

final class ApiManager {

    //TODO: swinject
    let configuration = AppConfiguration()
    let jsonDecoder = JSONDecoder()

    func characterList() -> Observable<CharacterList> {
        call(request: urlRequest(endpoint: "character"))
    }

    //TODO: another method for detail

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
