//
//  Configuration.swift
//  Droptune-iOS
//
//  Created by Daniel Westendorf on 1/2/20.
//  Copyright © 2020 Daniel Westendorf. All rights reserved.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum Server {
    static var baseURL: URL {
        return try! URL(string: ("https://" + Configuration.value(for: "APP_HOST") + "/"))!
    }

    static var loginSuccessURL: URL {
        return try! URL(string: ("https://" + Configuration.value(for: "LOGIN_SUCCESS_URL") + "/"))!
    }
    
    static var twitterAuthPath: String {
        return try! Configuration.value(for: "TWITTER_AUTH_PATH")
    }
    
    static var spotifyAuthPath: String {
        return try! Configuration.value(for: "SPOTIFY_AUTH_PATH")
    }
}
