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

// CONFIRMED KEYS
struct ResultDetails: Decodable {
    let id: String
    let created_at: String
    let updated_at: String
    let promoted_at: String
    let width: Int
    let height: Int
    let color: String
    let blur_hash: String
    let description: String
    let alt_description: String
    let urls: [variousURLs]
    let links: [variousLinks]
    // categories showing as empty list
    let categories: [String]
    let likes: Int
    let liked_by_user: Bool
    // current_user_collections showing as empty list
    let current_user_collections: [String]
    // sponsorships showing as None
    let sponsorship: String
    // topc_submission showing as empty dictionary
    let topic_submissions: String
    let user: [userDetails]
    // Confirmed data types through user (with corresponding notes)
    let tags: String
    
    
}

// CONFIRMED KEYS
// Confirmed Data Types
struct variousURLs: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let small_s3: String
}

// CONFIRMED KEYS
// Confirmed Data Types
struct variousLinks: Decodable {
    let `self`: String
    let html: String
    let download: String
    let download_location: String

}

// CONFIRMED KEYS
// Confirmed Data Types
struct userDetails: Decodable {
    let id: String
    let updated_at: String
    let username: String
    let name: String
    let first_name: String
    let last_name: String
    let twitter_username: String
    let portfolio_url: String
    let bio: String
    let location: String
    let links: [linkDetails2]
    let profile_image: [profileImageDetails]
    let instagram_username: String
    let total_collections: Int
    let total_likes: Int
    let total_photos: Int
    let accepted_tos: Bool
    let for_hire: Bool
    let social: [socialDetails]
    
}

// CONFIRMED KEYS
// Confirmed Data Types
struct linkDetails2: Decodable {
    let `self`: String
    let html: String
    let photos: String
    let likes: String
    let portfolio: String
    let following: String
    let followers: String
}

// CONFIRMED KEYS
// Confirmed Data Types
struct profileImageDetails: Decodable {
    let small: String
    let medium: String
    let lage: String
}

// CONFIRMED KEYS
// Confirmed Data Types
struct socialDetails: Decodable {
    let instagram_username: String
    let portfolio_url: String
    let twitter_username: String
    let paypal_email: String
}


struct tags_0_source: Decodable {
    let ancestry: [ancestryDetails]
    let title: String
    let subtitle: String
    let description: String
    let meta_title: String
    let meta_description: String
    let cover_photo: [coverPhotoDetails]
}

struct coverPhotoDetails: Decodable {
    
    let id: String
    let created_at: String
    let updated_at: String
    let promoted_at: String
    let width: Int
    let height: Int
    let color: String
    let blur_hash: String
    let description: String
    let alt_description: String
    let urls: [variousURLs2]
    let links: [variousLinks2]
    let categories: [String]
    let likes: Int
    let liked_by_user: Bool
    let current_user_collections: [String]
    let sponsorship: String
    let topic_submissions: [topicSubmissionDetails]
    let user: [userDetails2]
    
}


struct topicSubmissionDetails: Decodable {
    let health: [healthDetails]
}

struct healthDetails: Decodable {
    let status: String
    let approved_on: String
}



// CONFIRMED KEYS
// Confirmed Data Types
struct userDetails2: Decodable {
    let id: String
    let updated_at: String
    let username: String
    let name: String
    let first_name: String
    let last_name: String
    let twitter_username: String
    let portfolio_url: String
    let bio: String
    let location: String
    let links: [linkDetails3]
    let profile_image: [profileImageDetails2]
    let instagram_username: String
    let total_collections: Int
    let total_likes: Int
    let total_photos: Int
    let accepted_tos: Bool
    let for_hire: Bool
    let social: [socialDetails2]
    
}

// CONFIRMED KEYS
// Confirmed Data Types
struct linkDetails3: Decodable {
    let `self`: String
    let html: String
    let photos: String
    let likes: String
    let portfolio: String
    let following: String
    let followers: String
}



// CONFIRMED KEYS
// Confirmed Data Types
struct profileImageDetails2: Decodable {
    let small: String
    let medium: String
    let lage: String
}


// CONFIRMED KEYS
// Confirmed Data Types
struct socialDetails2: Decodable {
    let instagram_username: String
    let portfolio_url: String
    let twitter_username: String
    let paypal_email: String
}




// CONFIRMED KEYS
// Confirmed Data Types
struct variousURLs2: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let small_s3: String
}

// CONFIRMED KEYS
// Confirmed Data Types
struct variousLinks2: Decodable {
    let `self`: String
    let html: String
    let download: String
    let download_location: String

}











// CONFIRMED KEYS
// Confirmed Data Types
struct ancestryDetails: Decodable {
    let type: [typeDetails]
    let category: [categoryDetails]
}

// CONFIRMED KEYS
// Confirmed Data Types
struct typeDetails: Decodable {
    let slug: String
    let pretty_slug: String
}

// CONFIRMED KEYS
// Confirmed Data Types
struct categoryDetails: Decodable {
    let slug: String
    let pretty_slug: String
}





// CONFIRMED KEYS
// Confirmed Data Types
struct tags_1: Decodable {
    let type: String
    let title: String
}

// CONFIRMED KEYS
// Confirmed Data Types
struct tags_2: Decodable {
    let type: String
    let title: String
}
