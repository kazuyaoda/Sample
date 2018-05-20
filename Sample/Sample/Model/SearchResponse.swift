//
//  SearchResponse.swift
//  Sample
//
//  Created by 小田和哉 on 2018/05/19.
//  Copyright © 2018年 K.oda. All rights reserved.
//

import Foundation

struct SearchResponse<Item: Decodable>: Decodable {
    let totalCount: Int
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
