//
//  YoutubeSearchResponse.swift
//  Netflix
//
//  Created by Omar Tharwat on 7/24/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import Foundation

struct YoutubeSearchResponse : Codable {
    let items : [VideoElement]
}

struct VideoElement : Codable {
    let id : IdVideoElement
}
struct IdVideoElement : Codable {
    let kind : String
    let videoId : String
}
