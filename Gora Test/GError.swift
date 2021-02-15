//
//  Errors.swift
//  Gora Test
//
//  Created by Sergei Krupenikov on 15.02.2021.
//

import Foundation

enum GError: String, Error {
    
    case invalidURL = "This URL created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid."
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user"
}
