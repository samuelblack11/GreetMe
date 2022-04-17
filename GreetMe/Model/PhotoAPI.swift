//
//  PhotoAPI.swift
//  GreetMe
//
//  Created by Sam Black on 4/10/22.
//

import Foundation
import UIKit

// https://github.com/unsplash/unsplash-photopicker-ios
// https://github.com/unsplash/unsplash-photopicker-ios/blob/master/UnsplashPhotoPicker/UnsplashPhotoPicker/Classes/Models/UnsplashPhoto.swift

class PhotoAPI {
    


    enum Endpoints {
    
    static let apiKey = "GXA9JqJgKZiIkvWmnKVuzq1wWNPUN7GiVDHOTiq7f3A"
    static let secretKey = "DKnRQDO4TVGHcmhJVAcgq1VoMpFzvuoMVzql9kvkCmI"
    //static let baseURL = "https://api.unsplash.com"
    //static let baseURL = "https://api.unsplash.com/photos/?client_id=\(apiKey)"
    static let baseURL = "https://api.unsplash.com/search/photos?"
    case searchedWords(page_num: Int, userSearch: String)
    case random(randomSearch: String)

    var URLString: String{
        switch self {
            case .searchedWords(let page_num, let userSearch ):
            return Endpoints.baseURL + "page=\(page_num)&query=\(userSearch)&client_id=\(PhotoAPI.Endpoints.apiKey)"
        case .random(let randomSearch):
                return Endpoints.baseURL + ""
            }
        }
    var url: URL{ return URL(string: URLString)!}
    }
    
    
 
    
    
    //Must make this a class func in order to call the function properly in ImportPhotoViewController
    class func getPhoto(randomSearch: String) {
        
        // https://cocoacasts.com/networking-fundamentals-how-to-make-an-http-request-in-swift
        let pageNumber = Int.random(in: 0...5)
        let apiKey = "GXA9JqJgKZiIkvWmnKVuzq1wWNPUN7GiVDHOTiq7f3A"
        // Define url for the remote image, using the endpoint parameter
        let user_search = "baklava"
        //let url = URL(string: "https://api.unsplash.com/search/photos?query=\(user_search)/?client_id=\(apiKey)")!
        let url = Endpoints.searchedWords(page_num: pageNumber, userSearch: user_search).url
        // the request variables includes information the url session needs to perform the HTTP request
        // What do we gain from using URLRequest instead of passing in the url constant above? It allows us to configure the HTTP request the URL session performs. In this case, we want to specify it is a GET request and we want it in json format (rather than XML)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("v1", forHTTPHeaderField: "Accept-Version")
        // URLSession is the manager of the requests the app will perform
        // Create a dataTask, accepting 2 parameters: a URL and a completion Handler
        // The completion handler (a closure) is executed when the data task completes
        let task = URLSession.shared.dataTask(with: request)
            // Completion Handler is Below
            { data, response, error in
            // If data response not null
            print(data)
            print("DATA ------------")
            print(String(data: data!, encoding: .utf8))
            if let data = data {
                // Create JSONDecoder instance and invoke decode function, passing in type of value to decode from the supplied JSON object and the JSON object to decode
                print(response)
                print("data = data")
                if let pics = try? JSONDecoder().decode(PicResponse.self, from: data) {
                    print("Valid Response")
                    print(pics)
                }
                else {
                    print("Invalid Response")
                }
                //let image = UIImage(data: data)
            } else if let error = error {
                print("Request failed: \(error)")
            }
        }
        // This .resume() line actually executes the URLSessionDataTask
        task.resume()

    }
     
}



//UnsplashPhotoPickerConfiguration(accessKey: String,
                                 //secretKey: String,
                                 //query: String,
                                 //allowsMultipleSelection: Bool,
                                 //memoryCapacity: Int,
                                 //diskCapacity: Int)

// Recommended to present modally or as popover
//protocol UnsplashPhotoPickerDelegate: class {

  //  func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto])

  //func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker)
//}
