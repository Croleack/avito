//
//  FetchState.swift
//  avitoTestProject
//
//  Created by Enzhe Gaysina on 14.04.2024.
//

import Foundation

enum FetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case noResults
    case error(String)
}
