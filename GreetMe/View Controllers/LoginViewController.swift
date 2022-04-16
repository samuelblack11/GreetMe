//
//  ViewController.swift
//  GreetMe
//
//  Created by Sam Black on 3/30/22.
//

import UIKit
import AuthenticationServices


class LoginViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var greetingLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        print("viewDidLoad")
        // Do any additional setup after loading the view.
        setUpSignInAppleButton()
        
    }
    
    // When "Sign In with Apple" Button is Tapped, call handleAppleIdRequest()
    @IBAction func loginFunction(_ sender: Any) {
        performSegue(withIdentifier: "loginToMenu", sender: nil)
        //handleAppleIdRequest()
    }
    
    func spinActivityIndicator(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    // https://medium.com/@priya_talreja/sign-in-with-apple-using-swift-5cd8695a46b6
    // Use Authentication Services Framework to give users ability to sign into your services with their Apple ID
    func setUpSignInAppleButton() {
      let signInButton = ASAuthorizationAppleIDButton()
      signInButton.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
      signInButton.cornerRadius = 10
    }
    
    // Creates request using ASAuthorizationAppleIDProvider and initialize a controller ASAuthorizatioNCntroller to perform request
    @objc func handleAppleIdRequest() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    spinActivityIndicator(true)

    request.requestedScopes = [.fullName, .email]
    print("requestedScopes")
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    print("instantiated auth controller")
    authorizationController.delegate = self
    print("Delegate called")
    authorizationController.performRequests()
    print("performed Requests")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
    let userIdentifier = appleIDCredential.user
    let fullName = appleIDCredential.fullName
    let email = appleIDCredential.email
        print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
    spinActivityIndicator(false)
        }
        print("Perform Segue")
        performSegue(withIdentifier: "loginToMenu", sender: self)
    }
    
        
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
        debugPrint(error)
    }
    
    
    
    
    
    
    
    
    
    
    
    // https://medium.com/swift-programming/ios-make-an-awesome-video-background-view-objective-c-swift-318e1d71d0a2
    // https://github.com/ElvinJin/Video-Background-GIF
    // Make video background for login page
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

// Create extension of LoginViewController and conform it to specified protocol
extension LoginViewController: ASAuthorizationControllerDelegate {
    
}

