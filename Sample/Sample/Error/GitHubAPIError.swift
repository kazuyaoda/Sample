//
//  GitHubAPIError.swift
//  Sample
//
//  Created by 小田和哉 on 2018/05/19.
//  Copyright © 2018年 K.oda. All rights reserved.
//

import Foundation

struct GitHubAPIError: Decodable, Error {
    struct FieldError: Decodable {
        let resource: String
        let field: String
        let code: String
    }
    let message: String
    let fieldErrors: [FieldError]
}
