//
//  GitHubClientError.swift
//  Sample
//
//  Created by 小田和哉 on 2018/05/19.
//  Copyright © 2018年 K.oda. All rights reserved.
//

import Foundation

enum GitHubClientError: Error {
    case connectionError(Error)
    case responseParseError(Error)
    case apiError(GitHubAPIError)
}
