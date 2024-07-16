//
//  ListMoviesView.swift
//  ParallaxEffect
//
//  Created by daktech on 16/07/2024.
//

import SwiftUI

struct ListMoviesView: View {
    @Binding var images: [String]
    @Binding var titles: [String]
    var position: Int
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width
            let height = 1.25 * width
            let offset = -width / 2
            
            VStack(spacing: 20) {
                Text("Marvel Cinematic Universe")
                    .font(.title)
                    .bold()
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 22) {
                            ForEach(images.indices, id: \.self) { index in
                                ZStack {
                                    MoviePosterView(imageName: images[index])
                                        .frame(width: width, height: height)
                                        .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                            content.offset(x: phase.value * offset)
                                        }
                                        .overlay {
                                            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                                        }
                                        .overlay(alignment: .bottom) {
                                            Text(titles[index])
                                                .font(.title)
                                                .bold()
                                                .foregroundStyle(.white)
                                                .padding(.bottom, 44)
                                        }
                                }
                                .containerRelativeFrame(.horizontal)
                                .clipShape(RoundedRectangle(cornerRadius: 32))
                                .shadow(color: colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5), radius: 5, x: 0, y: 2)
                                .id(index)
                                .onAppear{
                                    withAnimation(.smooth) {
                                        proxy.scrollTo(self.position, anchor: .center)
                                    }
                                }
                            }
                        }
                        .scrollTargetLayout()
                        .padding([.top, .bottom], 20)
                    }
                    .frame(height: height)
                    .contentMargins(.horizontal, 44)
                    .scrollTargetBehavior(.paging)
                }
            }
        }
    }
}
