//
//  GroupInfo.swift
//  semonemo-iOS
//
//  Created by Ellen on 2022/07/20.
//

import Foundation

class GroupInfo: Codable {
    let id: Int
    let host: HostInfo
    let place: PlaceInfo
    let startDate: String
    let endData: String
}

class HostInfo: Codable {
    let nickname: String
}

class PlaceInfo: Codable {
    let summary: String
    let address: String
    let mapLink: String
}
