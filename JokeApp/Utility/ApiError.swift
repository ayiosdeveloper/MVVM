//
//  ApiError.swift
//  JokeApp
//
//  Created by Ankit Yadav on 10/06/23.
//

import Foundation

class APIError: Error {
    var code: Int
    var message: String
    var type: APIStatusCode
    
    init(code: Int, message: String, type: APIStatusCode) {
        self.code = code
        self.message = message
        self.type = type
    }
    
    init(type: APIStatusCode) {
        self.code = type.errorCode ?? -1
        self.message = type.message
        self.type = type
    }
}

extension Error {
    func getAPIError() -> APIError {
        if let error = self as? APIError {
            return error
        }
        for apiError in APIStatusCode.allCases where apiError.value == self.errorCode {
            return APIError(code: apiError.value, message: localizedDescription, type: apiError)
        }
        return APIError(code: errorCode ?? -1, message: localizedDescription, type: .other)
    }
    
    func jsonDecodingFailed() -> APIError {
        let error = APIStatusCode.jsonDecondingFailed
        let apiError = APIError(code: error.value,
                                message: StringConstants.GenericError.jsonDecoding,
                                type: error)
        return apiError
    }
}

enum APIStatusCode: Error, CaseIterable {
    case sucesss
    case noInternet
    case internalServerError
    case serviceUnavailable
    case notFound
    case jsonDecondingFailed
    case dataWithNoInternet
    case cancelled
    case other
    
    var value: Int {
        switch self {
        case .sucesss:
            return 200
        case .noInternet:
            return -1009
        case .internalServerError:
            return 500
        case .serviceUnavailable:
            return 503
        case .notFound:
            return 404
        case .jsonDecondingFailed:
            return -2
        case .dataWithNoInternet:
            return -3
        case .other:
            return -1
        case .cancelled:
            return -999
        }
    }
    
    var message: String {
        switch self {
        case .sucesss:
            return ""
        case .noInternet:
            return StringConstants.GenericError.noInternet
        case .jsonDecondingFailed:
            return StringConstants.GenericError.jsonDecoding
        case .internalServerError:
            return StringConstants.GenericError.internalServerError
        case .serviceUnavailable:
            return StringConstants.GenericError.serviceUnavailable
        case .notFound:
            return StringConstants.GenericError.serviceNotFound
        default:
            return StringConstants.GenericError.unknown
        }
    }
}

extension Error {
    var errorCode: Int? {
        return (self as NSError).code
    }
}
