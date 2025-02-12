//
//  ContentView.swift
//  Scout
//
//  Created by Kari Groszewska on 2/10/25.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var searchText = ""
    @State private var ratedMovies: [String: Double] = [:]
    @State private var popularMovies: [Movie] = []
    @State private var allMovies: [Movie] = [] // Cache all movies
    
    // Load movies only once when view appears
    private func loadMovies() {
        if let path = Bundle.main.path(forResource: "movies", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let movieData = try? JSONDecoder().decode(MovieData.self, from: data) {
            popularMovies = movieData.popular
            allMovies = movieData.all
        }
    }
    
    // Compute search results from cached movies
    var searchResults: [Movie] {
        if searchText.isEmpty {
            return []
        }
        return allMovies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    private var hasCustomRatings: Bool {
        let customMovies = Set(ratedMovies.keys).subtracting(popularMovies.map(\.title))
        return !customMovies.isEmpty
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "1a1a1a"), Color(hex: "000000")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Text("🎬 Rate Your Movies")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 8)
                
                Text("Help us discover your taste in cinema")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(hex: "E50914"))
                    .padding(.bottom, 2)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(hex: "E50914"))
                    TextField("Search movies...", text: $searchText)
                        .foregroundColor(.white)
                        .autocorrectionDisabled()
                }
                .padding(12)
                .background(Color(hex: "2A2A2A"))
                .cornerRadius(12)
                .padding(.horizontal)
                
                if !searchText.isEmpty {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(searchResults.prefix(10)) { movie in
                                MovieCard(movie: movie, rating: Binding(
                                    get: { self.ratedMovies[movie.title, default: 0] },
                                    set: { self.ratedMovies[movie.title] = $0 }
                                ))
                            }
                        }
                        .padding(.horizontal)
                    }
                } else if !hasCustomRatings {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("🍿 Popular Picks")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        Text("Start with these crowd favorites")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "E50914"))
                            .padding(.horizontal)
                        
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(popularMovies) { movie in
                                    MovieCard(movie: movie, rating: Binding(
                                        get: { self.ratedMovies[movie.title, default: 0] },
                                        set: { self.ratedMovies[movie.title] = $0 }
                                    ))
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(Array(ratedMovies.keys), id: \.self) { movieTitle in
                                if let movie = allMovies.first(where: { $0.title == movieTitle }) {
                                    MovieCard(movie: movie, rating: Binding(
                                        get: { self.ratedMovies[movieTitle, default: 0] },
                                        set: { self.ratedMovies[movieTitle] = $0 }
                                    ))
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                NavigationLink(destination: HomeView()) {
                    HStack {
                        Text("Show Recommendations")
                            .font(.system(size: 16, weight: .bold))
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 16))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(ratedMovies.count >= 2 ? Color(hex: "E50914") : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
                .disabled(ratedMovies.count < 2)
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
        }
        .onAppear {
            loadMovies()
        }
    }
}

#Preview {
    OnboardingView(hasCompletedOnboarding: .constant(false))
}
