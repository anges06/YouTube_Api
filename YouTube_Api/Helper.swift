//
//  Helper.swift
//  YoutubeApi
//
//  Created by anges on 09.02.19.
//  Copyright © 2019 anges. All rights reserved.
//

import Foundation

class Helper
{

//Structs for parsing JSON data
struct YouTubeData: Decodable {
    let items: [yData]
}

struct yData: Decodable {
    var statistics: YtStatistics
    let snippet: ytSnippet
    let id: String
}

struct YtStatistics: Decodable {
    var subscriberCount: String
    let videoCount: String
    let viewCount: String
    let hiddenSubscriberCount: Bool
    let commentCount: String
}

struct ytSnippet: Decodable {
    let thumbnails: thumbnailsData
    let title: String
    let customUrl: String
    let description: String
    let publishedAt: String
}

struct thumbnailsData: Decodable {
    let medium: mediumData
    let high: highData
}

struct mediumData: Decodable {
    let url: String
    let width: Int
    let height: Int
}

struct highData: Decodable {
    let url: String
    let width: Int
    let height: Int
}
}
