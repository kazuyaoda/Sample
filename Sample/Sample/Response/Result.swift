//
//  Result.swift
//  Sample
//
//  Created by 小田和哉 on 2018/05/20.
//  Copyright © 2018年 K.oda. All rights reserved.
//

import Foundation

enum Result<T, Error:Swift.Error> {
    case success(T)
    case failure(Error)
    
    init(value: T){
        self = .success(value)
    }
    
    init(error: Error){
        self = .failure(error)
    }
}
