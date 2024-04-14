//
//  AlbumSearchView.swift
//  avitoTestProject
//
//  Created by Enzhe Gaysina on 14.04.2024.
//

import SwiftUI

struct AlbumSearchView: View {
    
    @StateObject var viewModel = AlbumListViewModel()
    
    var body: some View {
	   NavigationView {
		  
		  Group {
			 if viewModel.searchTerm.isEmpty {
				SearchPlaceholderView(searchTerm: $viewModel.searchTerm)
			 } else {
				AlbumListView(viewModel: viewModel)
			 }
		  }
		  .searchable(text: $viewModel.searchTerm)
		  .navigationTitle("Search Albums")
	   }
    }
}
