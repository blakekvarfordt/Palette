//
//  UnsplashRoute.swift
//  Palette
//
//  Created by DevMountain on 4/2/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation

enum UnsplashRoute {
    
    static let baseUrl = "https://api.unsplash.com/"
    //TODO: - Input Unsplash Client Id
    static let clientId = "0823b860251b1da95518ce7edd00a0dd0916b81d6afe977dbe6805fa22cac041"
    
    case random
    case featured
    case doubleRainbow
    
    var path: String {
        switch self {
        case .random:
            return "/photos/random"
        case .featured:
            return "/photos/"
        case .doubleRainbow:
            return "/search/photos"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items = [
            URLQueryItem(name: "client_id", value: UnsplashRoute.clientId),
            URLQueryItem(name: "count", value: "10")
        ]
        switch self {
        case .random, .featured:
            return items
        case .doubleRainbow:
            items.append(URLQueryItem(name: "query", value: "double rainbow"))
            return items
        }
    }
    
    var fullUrl: URL? {
        guard let url = URL(string: UnsplashRoute.baseUrl)?.appendingPathComponent(path) else { return nil }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        return components?.url
    }
}
