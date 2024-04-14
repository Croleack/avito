//
//  UserDefaultService.swift
//  avitoTestProject
//
//  Created by Enzhe Gaysina on 14.04.2024.
//

import Foundation

final class UserDefaultService {
    static let shared = UserDefaultService()
    private let userDefaults = UserDefaults.standard
    
    func saveSearchTerm(_ term: String) {
	   guard !term.isEmpty else { return }
	   var searchTerms = userDefaults.stringArray(forKey: "SearchTerms") ?? []
	   if !searchTerms.contains(term) {
		  searchTerms.insert(term, at: 0)
		  if searchTerms.count > 5 {
			 searchTerms.removeLast()
		  }
		  userDefaults.set(searchTerms, forKey: "SearchTerms")
		  print("Search term saved:", term)
		  print("Search terms:", searchTerms)
	   }
    }
}
