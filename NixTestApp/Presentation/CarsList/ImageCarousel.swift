//
//  ImageCarousel.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageCarousel: View {
    @State private var selection = 0
    var images: [CarImage]
    var height: CGFloat
    
    var body: some View {
        TabView(selection : $selection){
            ForEach(0..<images.count, id: \.self){ index in
                WebImage(url: URL(string: images[index].url)) { image in
                    image.resizable()
                } placeholder: {
                    Rectangle().foregroundColor(.white)
                }
                .indicator(.activity)
                .frame(height: height)
                .scaledToFit()
                .clipped()
            }
        }
        .frame(height: height)
        .tabViewStyle(.page)
    }
}
