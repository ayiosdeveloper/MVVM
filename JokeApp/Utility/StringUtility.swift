//
//  StringUtility.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import Foundation

struct StringConstants {
    
    struct StatusCode {
        static var success = "SUCCESS"
        static var failure = "FAILURE"
        static var notAvailable = "NOT_AVAILABLE"
        static var invalid = "INVALID"
    }
    
    struct GenericError {
        static var unknown = "Something went wrong. Please try again later"
        static var jsonDecoding = "Unable to decode json"
        static var noInternet = "Please check your internet connection"
        static var internalServerError = "Internal Server Error"
        static var serviceNotFound = "Service not found"
        static var serviceUnavailable = "Service Unavailable"
    }
    
    struct cellIdentifiers {
        static var cellIdentifier = "jokeTableViewCell"
    }
}

