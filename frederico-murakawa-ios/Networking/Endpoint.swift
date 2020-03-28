//
//  Endpoint.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/27/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation

public enum Endpoint {
    case articles
}

extension Endpoint: RequestProviding {
    public var urlRequest: URLRequest {
        switch self {
        case .articles:
            guard let url = URL(string: "http://www.ckl.io/challenge") else {
                preconditionFailure("Invalid URL used to create URL instance")
            }
            
            return URLRequest(url: url)
        }
    }
}
