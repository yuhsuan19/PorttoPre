//
//  Asset.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/14.
//

import Foundation

struct Asset: Codable {
    let name: String?
    let description: String?
    let imageURL: URL?
    let thumbnailURL: URL?
    let permalink: URL?
    
    let collection: Collection?
    
    enum CodingKeys: String, CodingKey {
        case name, description, permalink, collection
        case imageURL = "image_url"
        case thumbnailURL = "image_thumbnail_url"
    }
}

extension Asset {
    struct Collection: Codable {
        let name: String?
    }
}
