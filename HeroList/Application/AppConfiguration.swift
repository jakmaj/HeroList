//
//  AppConfiguration.swift
//  HeroList
//
//  Created by Jakub Majdl on 08.01.2023.
//

import Foundation

final class AppConfigurations {
    lazy var apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as! String
    lazy var apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as! String
}
