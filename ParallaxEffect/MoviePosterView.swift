//
//  MoviePosterView.swift
//  ParallaxEffect
//
//  Created by Anup D'Souza on 14/06/24.
//  🕸️ https://www.anupdsouza.com
//  🔗 https://twitter.com/swift_odyssey
//  👨🏻‍💻 https://github.com/anupdsouza
//  ☕️ https://www.buymeacoffee.com/anupdsouza
//

import SwiftUI

struct MoviePosterView: View {
    let imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 32))
    }
}

#Preview {
    MoviePosterView(imageName: "1")
}
