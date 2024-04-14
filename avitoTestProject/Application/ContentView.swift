//
//  ContentView.swift
//  avitoTestProject
//
//  Created by Enzhe Gaysina on 14.04.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
	   TabView {
		  
		  SearchView()
			 .tabItem {
				Label("Search", systemImage: "magnifyingglass")
			 }
		  
		  AlbumSearchView()
			 .tabItem {
				Label("Albums", systemImage: "music.note")
			 }
	   }
    }
}
