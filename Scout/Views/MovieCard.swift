//
//  MovieCard.swift
//  Scout
//
//  Created by Kari Groszewska on 2/11/25.
//

import SwiftUI


struct MovieCard: View {
    let movie: Movie
    @Binding var rating: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(movie.title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            HStack {
                ForEach(0..<5) { index in
                    Image(systemName: index < Int(rating) ? "star.fill" : "star")
                        .font(.system(size: 24))
                        .foregroundColor(Color(hex: "E50914"))
                        .onTapGesture {
                            rating = Double(index + 1)
                        }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "2A2A2A"))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
} 
