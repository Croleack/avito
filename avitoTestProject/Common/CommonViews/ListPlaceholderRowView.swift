//
//  ListPlaceholderRowView.swift
//  avitoTestProject
//
//  Created by Enzhe Gaysina on 14.04.2024.
//

import SwiftUI

struct ListPlaceholderRowView: View {
    
    let state: FetchState
    let loadMore: () -> Void
    
    var body: some View {
	   switch state {
	   case .good:
		  Color.clear
			 .onAppear {
				loadMore()
			 }
	   case .isLoading:
		  ProgressView()
			 .progressViewStyle(.circular)
			 .frame(maxWidth: .infinity)
	   case .loadedAll:
		  EmptyView()
	   case .noResults:
		  Text("Sorry Could not find anything.")
			 .foregroundColor(.gray)
	   case .error(let message):
		  Text(message)
			 .foregroundColor(.pink)
	   }
    }
}
