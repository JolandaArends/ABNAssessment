//
//  APIError.swift
//  ABNAssessment
//
//  Created by Jolanda Arends on 04/03/2024.
//

/// Errors that can occur when dealing with the API
enum APIError: Error {
    case couldNotParseResult,
         serverRespondedWithError
}
