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
    func call<T: Decodable>(request: ApiRequest) -> Observable<T>
}

final class ApiManagerImpl: ApiManager {

    @Injected
    var configuration: AppConfiguration

    let jsonDecoder = JSONDecoder()

    func call<T: Decodable>(request: ApiRequest) -> Observable<T> {
        let url = request.prepareUrl(baseUrl())
        let urlRequest = URLRequest(url: url)

        return URLSession.shared.rx.data(request: urlRequest)
            .map { [weak self] data in
                guard let self else { throw RuntimeError("deallocated self") }

                return try self.jsonDecoder.decode(T.self, from: data)
            }
    }

    private func baseUrl() -> URL {
        guard var url = URL(string: configuration.apiBaseURL) else {
            fatalError("Error creating base api URL")
        }

        url.append(queryItems: [
            .init(name: "api_key", value: configuration.apiKey),
            .init(name: "format", value: "json")
        ])
        return url
    }

}
