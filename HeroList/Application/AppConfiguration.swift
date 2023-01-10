//
//  AppConfiguration.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation

protocol AppConfiguration {
    var apiKey: String { get }
    var apiBaseURL: String { get }
}

final class AppConfigurationImpl: AppConfiguration {
    lazy var apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as! String
    lazy var apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as! String
}
