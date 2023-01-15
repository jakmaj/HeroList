//
//  ApiRequest.swift
//  HeroList
//
//  Created by Jakub Majdl on 15.01.2023.
//

import Foundation

protocol ApiRequest {

    func prepareUrl(_ url: URL) -> URL

}
