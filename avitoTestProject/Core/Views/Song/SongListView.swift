//
//  SongListView.swift
//  avitoTestProject
//
//  Created by Enzhe Gaysina on 14.04.2024.
//

import SwiftUI

struct SongListView: View {
    
    @ObservedObject var viewModel: SongListViewModel
    
    var body: some View {
	   
	   List {
		  ForEach(viewModel.songs) { song in
			 NavigationLink {
				SongDetailView(song: song)
			 } label: {
				SongRowView(song: song)
			 }
		  }
		  
		  ListPlaceholderRowView(state: viewModel.state,
							loadMore: viewModel.loadMore)
	   }
	   .listStyle(.plain)
	   
    }
}
