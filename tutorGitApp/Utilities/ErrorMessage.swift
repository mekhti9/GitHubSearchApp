//
//  ErrorMessage.swift
//  tutorGitApp
//
//  Created by mehdimagerramov on 11.01.2024.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again and again and again and again until you win."
    case unableToComplete = "Unable to complete your request. Got me a check i got a check sheesh."
    case invalidResponse = "Invalid response from server."
    case invalidData = "The data received from server was invalid."
}
