//
//  GitHubAPI.swift
//  Sample
//
//  Created by 小田和哉 on 2018/05/19.
//  Copyright © 2018年 K.oda. All rights reserved.
//

import Foundation

final class GitHubAPI {
    struct SearchRepositories: GitHubRequest {
        var body: Encodable?
        let keyword: String
        
        typealias Response = SearchResponse<Repository>
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/search/repositories"
        }
        
        var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "q", value: keyword)]
        }
    }
    
    struct SearchUsers: GitHubRequest {
        var body: Encodable?
        let keyword: String
        
        typealias Response = SearchResponse<User>
        
        var path: String {
            return "/search/users"
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "q", value: keyword)]
        }
    }
}
