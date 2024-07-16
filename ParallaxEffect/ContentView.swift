//
//  ContentView.swift
//  ParallaxEffect
//
//  Created by Anup D'Souza on 14/06/24.
//  🕸️ https://www.anupdsouza.com
//  🔗 https://twitter.com/swift_odyssey
//  👨🏻‍💻 https://github.com/anupdsouza
//  ☕️ https://www.buymeacoffee.com/anupdsouza
//

import SwiftUI

struct ContentView: View {
    private let images = (1...7).map { "\($0)" }
    private let titles = [
        "Iron Man",
        "Captain America: The First Avenger",
        "The Avengers",
        "Thor: Ragnarok",
        "Black Panther",
        "Avengers: Infinity War",
        "Avengers: Endgame"
    ]
    
    @Namespace var animation
    
    var body: some View {
        GeometryReader {
            let screenSize = $0.size
            
            NavigationStack{
                ScrollView {
                    VStack(spacing: 0) {
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 15), count: 2), spacing: 15) {
                            ForEach(images.indices, id: \.self) { index in
                                NavigationLink(value: ImagePath(images: .constant(images), titles: .constant(titles), position: index)) {
                                    let image = images[index]
                                    CardView(image: image)
                                        .frame(height: screenSize.height * 0.4)
                                        .matchedGeometryEffect(id: index, in: animation)
                                }
                            }
                        }
                        .padding(15)
                    }
                    .navigationDestination(for: ImagePath.self) { data in
                        ListMoviesView(images: data.$images, titles: data.$titles, position: data.position)
                    }
                }
            }
        }
    }
}

struct ImagePath: Hashable {
    var id: UUID = .init()
    @Binding var images: [String]
    @Binding var titles: [String]
    var position: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: ImagePath, rhs: ImagePath) -> Bool {
        lhs.id == rhs.id
    }
}

struct CardView: View {
    @State var image: String
    
    var body: some View{
        GeometryReader{
            let size = $0.size
            Image("\(image)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipShape(.rect(cornerRadius: 15))
        }
    }
}
