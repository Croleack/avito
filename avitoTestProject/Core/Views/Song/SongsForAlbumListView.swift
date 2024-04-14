//
//  SongsForAlbumListView.swift
//  avitoTestProject
//
//  Created by Enzhe Gaysina on 14.04.2024.
//

import SwiftUI

struct SongsForAlbumListView: View {
    
    @ObservedObject var songsViewModel: SongsForAlbumListViewModel
    let selectedSong: Song?
    
    var body: some View {
	   ScrollViewReader { proxy in
		  ScrollView {
			 if songsViewModel.state == .isLoading {
				ProgressView()
				    .progressViewStyle(.circular)
			 } else if songsViewModel.songs.count > 0 {
				SongsGridView(songs: songsViewModel.songs, selectedSong: selectedSong)
				    .padding(.top, 30)
				    .onAppear {
					   if let song = selectedSong {
						  withAnimation {
							 proxy.scrollTo(song.trackNumber, anchor: .center)
						  }
					   }
				    }
			 }
		  }
	   }
    }
}

struct SongsGridView: View {
    
    let songs: [Song]
    let selectedSong: Song?
    
    var body: some View {
	   Grid(horizontalSpacing: 20) {
		  ForEach(songs) { song in
			 GridRow {
				SongCell(song: song, selectedSong: selectedSong)
			 }
			 .foregroundColor(selectedSong?.id == song.id ? Color.accentColor : Color.black)
			 .id(song.trackNumber)
			 
			 Divider()
				.gridCellUnsizedAxes(.horizontal)
			 
		  }
	   }
	   .padding([.bottom, .leading])
    }
}

struct SongStackView: View {
    
    let songs: [Song]
    let selectedSong: Song?
    
    var body: some View {
	   VStack(spacing: 10) {
		  ForEach(songs) { song in
			 SongCell(song: song, selectedSong: selectedSong)
			 
			 Divider()
		  }
	   }
    }
}

struct SongCell: View {
    
    let song: Song
    let selectedSong: Song?
    
    var body: some View {
	   HStack(spacing: 10) {
		  Text("\(song.trackNumber)")
			 .font(.footnote)
			 .frame(width: 25, alignment: .trailing)
		  
		  Text(song.trackName)
			 .lineLimit(2)
		  
		  Spacer()
		  
		  Text(formattedDuration(time: song.trackTimeMillis))
			 .font(.footnote)
			 .frame(width: 40)
		  
		  BuySongButton(urlString: song.previewURL,
					 price: song.trackPrice,
					 currency: song.currency)
		  .padding(.trailing)
	   }
    }
}

// Вспомогательная функция для форматирования времени
fileprivate func formattedDuration(time: Int) -> String {
    
    let timeInSeconds = time / 1000
    
    let interval = TimeInterval(timeInSeconds)
    let formatter = DateComponentsFormatter()
    formatter.zeroFormattingBehavior = .pad
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .positional
    
    return formatter.string(from: interval) ?? ""
}
