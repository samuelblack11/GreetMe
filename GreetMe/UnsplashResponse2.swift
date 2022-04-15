//
//  UnsplashResponse2.swift
//  GreetMe
//
//  Created by Sam Black on 4/14/22.
//

import Foundation


struct Picture: Decodable {
    
    let url: URL
    let statusCode: Int
    let headers: [responseDetails]
}

struct responseDetails: Decodable {
    let accept_ranges: Data
    let access_control_allow_origin: String
    let age: Int
    let cache_control: String
    let content_encoding: Data
    let content_language: String
    let content_length: Int
    let content_type: String
    let date: String
    let eTag: String
    let link: String
    let server: String
    let strict_transport_security: String
    let vary: String
    let via: String
    let access_control_allow_headers: String
    let access_control_expose_headers: String
    let access_control_request_method: String
    let x_cache: String
    let x_cache_hits: Int
    let x_per_page: Int
    let x_ratelimit_limit: Int
    let x_ratelimit_remaining: Int
    let x_request_id: String
    let x_runtime: String
    let x_served_by: String
    let x_timer: String
    let x_total: Int
    let x_unsplash_version: String
    
    
    
}
