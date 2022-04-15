//
//  UnsplashResponse.swift
//  GreetMe
//
//  Created by Sam Black on 4/13/22.
//

import Foundation
import UIKit

// Define a struct that conforms to the decodable protocol, define properties listed here:
// This will be used in the completion handler of the getPhoto function

struct Pic: Decodable {
    let id: String
    let created_at: String
    let updated_at: String
    let width: Int
    let height: Int
    let color: String
    let blur_hash: String
    let downloads: Int
    let likes: Int
    let liked_by_user: Bool
    let description: String
    let exift: [exif_details]
    let location: [location_details]
    let current_user_collections: [user_details]
    let urls: [url_details]
    let links: [link_details]
    let user: [userDetailsTwo]
}

struct exif_details: Decodable {
    let make: String
    let model: String
    let exposure_time: String
    let aperture: String
    let focal_length: String
    let iso: Int
}

struct location_details: Decodable {
    let name: String
    let city: String
    let country: String
    let position: [position_details]
}

struct position_details: Decodable {
    let latitude: Float
    let longitude: Float
    
}

struct user_details: Decodable {
    let id: Int
    let title: String
    let published_at: String
    let last_collected_at: String
    let updated_at: String
    //verify data type
    let cover_photo: String
    //verify data type
    let user: String
}

struct url_details: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct link_details: Decodable {
    let `self`: String
    let html: String
    let download: String
    let download_location: String
}

struct userDetailsTwo: Decodable {
     let id: String
     let updated_at: String
     let username: String
     let name: String
     let portfolio_url: String
     let bio: String
     let location: String
     let total_likes: Int
     let total_photos: Int
     let total_collections: Int
     let instagram_username: String
     let twitter_username: String
     let links: [link_details_2]
}

struct link_details_2: Decodable {
    let `self`: String
    let html: String
    let photos: String
    let likes: String
    let portfolio: String
}
