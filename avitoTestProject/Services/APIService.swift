//
//  APIService.swift
//  avitoTestProject
//
//  Created by Enzhe Gaysina on 14.04.2024.
//

import Foundation

final class APIService {
    
    func fetchAlbums(searchTerm: String, page: Int, limit: Int, completion: @escaping(Result<AlbumResult,APIError>) -> Void) {
	   let url = createURL(for: searchTerm, type: .album, page: page, limit: limit)
	   fetch(type: AlbumResult.self, url: url, completion: completion)
    }
    
    func fetchAlbum(with albumID: Int, completion: @escaping(Result<AlbumResult,APIError>) -> Void) {
	   let url = createURL(for: albumID, type: .album)
	   fetch(type: AlbumResult.self, url: url, completion: completion)
    }
    
    func fetchSongs(for albumID: Int, completion: @escaping(Result<SongResult,APIError>) -> Void) {
	   let url = createURL(for: albumID, type: .song)
	   fetch(type: SongResult.self, url: url, completion: completion)
    }
    
    func fetchSongs(searchTerm: String, page: Int, limit: Int, completion: @escaping(Result<SongResult,APIError>) -> Void) {
	   let url = createURL(for: searchTerm, type: .song, page: page, limit: limit)
	   fetch(type: SongResult.self, url: url, completion: completion)
    }
    
    func fetch<T: Decodable>(type: T.Type, url: URL?, completion: @escaping(Result<T,APIError>) -> Void) {
	   
	   guard let url = url else {
		  let error = APIError.badURL
		  completion(Result.failure(error))
		  return
	   }
	   
	   URLSession.shared.dataTask(with: url) { data, response, error in
		  
		  if let error = error as? URLError {
			 completion(Result.failure(APIError.urlSession(error)))
		  } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
			 completion(Result.failure(APIError.badResponse(response.statusCode)))
		  } else if let data = data {
			 
			 do {
				let result = try JSONDecoder().decode(type, from: data)
				completion(Result.success(result))
			 } catch {
				completion(Result.failure(.decoding(error as? DecodingError)))
			 }
		  }
	   }.resume()
    }
    
    func createURL(for searchTerm: String, type: EntityType, page: Int?, limit: Int?) -> URL? {
	   let baseURL = "https://itunes.apple.com/search"
	   var queryItems = [URLQueryItem(name: "term", value: searchTerm),
					 URLQueryItem(name: "entity", value: type.rawValue)]
	   
	   if let page = page, let limit = limit {
		  let offset = page * limit
		  queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
		  queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
	   }
	   
	   var components = URLComponents(string: baseURL)
	   components?.queryItems = queryItems
	   return components?.url
    }
    
    func createURL(for id: Int,type: EntityType) -> URL? {
	   let baseURL = "https://itunes.apple.com/lookup"
	   
	   let queryItems = [URLQueryItem(name: "id", value: String(id)),
					 URLQueryItem(name: "entity", value: type.rawValue)]
	   
	   var components = URLComponents(string: baseURL)
	   components?.queryItems = queryItems
	   return components?.url
    }
}
