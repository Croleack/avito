//
//  BuySongButton.swift
//  avitoTestProject
//
//  Created by Enzhe Gaysina on 14.04.2024.
//

import SwiftUI

struct BuySongButton: View {
    
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
	   if let price = price {
		  BuyButton(urlString: urlString,
				  price: price,
				  currency: currency)
	   } else {
		  Text("ALBUM ONLY")
			 .font(.footnote)
			 .foregroundColor(.gray)
	   }
    }
}


struct BuyButton: View {
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
	   if let url =  URL(string: urlString),
		 let priceText = formattedPrice() {
		  Link(destination: url) {
			 Text(priceText)
		  }
		  .buttonStyle(BuyButtonStyle())
	   }
    }
    
    func formattedPrice() -> String? {
	   
	   guard let price = price else {
		  return nil
	   }
	   
	   let formatter = NumberFormatter()
	   formatter.numberStyle = .currency
	   formatter.currencyCode = currency
	   
	   let priceString = formatter.string(from: NSNumber(value: price))
	   return priceString
    }
}

struct BuyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
	   configuration.label
		  .foregroundColor(.accentColor)
		  .padding(.vertical, 5)
		  .padding(.horizontal, 10)
		  .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.accentColor, lineWidth: 1))
		  .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
