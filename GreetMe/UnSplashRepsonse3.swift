//
//  UnSplashRepsonse3.swift
//  GreetMe
//
//  Created by Sam Black on 4/14/22.
//

import Foundation
import UIKit

struct PicResponse: Decodable {
    let total: Int
    let total_pages: Int
    let results: [ResultDetails]
}

struct ResultDetails: Decodable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let color: String
    let blur_hash: String
    let likes: Int
    let likes_by_user: Bool
    let description: String
    let user: [userDetails]
}

struct userDetails: Decodable {
    let id: String
    let username: String
    let name: String
    let first_name: String
    let last_name: String
    let instagram_username: String
    let twitter_username: String
    let portfolio_url: String
    let profile_image: [profileImageSize]
    let links: [variousLinks]
}

struct profileImageSize: Decodable {
    let small: String
    let medium: String
    let large: String
}

struct variousLinks: Decodable {
    let `self`: String
    let html: String
    let photos: String
    let likes: String
}

struct ResultDetails2: Decodable {
    let current_user_collections: [String]
    let urls: [variousURLs]
    let links: [variousLinks2]
}

struct variousURLs: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct variousLinks2: Decodable {
    let `self`: String
    let html: String
    let download: String
}
