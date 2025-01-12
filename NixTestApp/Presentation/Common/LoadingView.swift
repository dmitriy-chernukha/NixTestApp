//
//  LoadingView.swift
//  NixTestApp
//
//  Created by Dim on 12.01.2025.
//

import SwiftUI

struct LoadingView: View {
    @State private var rotation = 0.0
    
    var body: some View {
        ZStack {
            Color.black.opacity(Constants.opacity.rawValue)
                .ignoresSafeArea()
            
            VStack {
                Circle()
                    .trim(from: Constants.startTrim.rawValue, to: Constants.endTrim.rawValue)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [Color.gray, Color.black, Color.gray]),
                            center: .center
                        ),
                        style: StrokeStyle(lineWidth: Constants.lineWidth.rawValue, lineCap: .round)
                    )
                    .frame(width: Constants.frameSide.rawValue, height: Constants.frameSide.rawValue)
                    .rotationEffect(Angle(degrees: rotation))
                    .onAppear {
                        withAnimation(Animation.linear(duration: Constants.duration.rawValue)
                            .repeatForever(autoreverses: false)) {
                                rotation = Constants.rotation.rawValue
                            }
                    }
                
                Text("loadingViewTitle")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 16)
            }
        }
    }
}

fileprivate extension LoadingView {
    enum Constants: Double {
        case opacity = 0.5
        case rotation = 360
        case frameSide = 80
        case duration = 1.1
        case lineWidth = 8
        case startTrim = 0.3
        case endTrim = 1.0
    }
}

