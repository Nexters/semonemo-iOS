//
//  SemonemoAPI.swift
//  semonemo-iOS
//
//  Created by Ellen on 2022/07/20.
//

import Foundation
import Alamofire

enum SemonemoAPI {
    static let baseURL = "http://api-dev.semonemo.xyz/"
    
    case getGroupList
    case getUserInfo(id: String)
    
    var request: (url: String, method: HTTPMethod) {
        switch self {
        case .getGroupList:
            return (url: SemonemoAPI.baseURL + "api/meetings", method: .get)
        case .getUserInfo(let id):
            return (url: SemonemoAPI.baseURL + "api/users/\(id)", method: .get)
        }
    }
}
