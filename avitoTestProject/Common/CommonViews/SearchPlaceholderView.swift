//
//  SearchPlaceholderView.swift
//  avitoTestProject
//
//  Created by Enzhe Gaysina on 14.04.2024.
//

import SwiftUI

struct SearchPlaceholderView: View {
    
    @Binding var searchTerm: String
    @State private var suggestions: [String]
    @State private var lastRemovedSuggestion: String?
    
    init(searchTerm: Binding<String>) {
	   self._searchTerm = searchTerm
	   _suggestions = State(initialValue: UserDefaults.standard.stringArray(forKey: "SearchSuggestions") ?? ["rammstein", "cry to me", "maneskin", "eminem", "nickelback"])
	   _lastRemovedSuggestion = State(initialValue: nil)
    }
    
    var body: some View {
	   VStack(spacing: 20) {
		  Text("History")
			 .font(.title)
		  ForEach(suggestions, id: \.self) { text in
			 Button {
				searchTerm = text
				updateSuggestions(with: text)
			 } label: {
				Text(text)
				    .font(.title2)
			 }
		  }
	   }
    }
    
    private func updateSuggestions(with newSuggestion: String) {
	   if suggestions.count < 5 {
		  suggestions.insert(newSuggestion, at: 0)
	   } else {
		  if let lastRemoved = lastRemovedSuggestion {
			 suggestions.append(lastRemoved)
		  }
		  suggestions.removeLast()
		  suggestions.insert(newSuggestion, at: 0)
	   }
	   UserDefaults.standard.set(suggestions, forKey: "SearchSuggestions")
	   print("Suggestions updated with:", newSuggestion)
	   print("Suggestions:", suggestions)
    }
}
