//
//  MenuView.swift
//  Jigsaw
//
//  Created by ANDELA on 28/04/2024.
//

import SwiftUI

struct MenuView: View {
  @State private var showEasyMode = false
  @State private var showHardMode = false

  var body: some View {
    ZStack {
      Image("jigsaw")
        .resizable()
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
      VStack(spacing: 30) {
        Text("Choose a Level")
          .font(Font.custom("Bebas Neue", size: 28))
          .foregroundColor(.yellow)
        
        VStack(spacing: 20) {
          Button(action: {
            showEasyMode.toggle()
          }) {
            RoundedRectangle(cornerRadius: 20)
              .fill(Color.blue)
              .frame(width: 200, height: 120)
              .overlay {
                Text("Easy")
                  .font(Font.custom("Bebas Neue", size: 28))
                  .foregroundColor(.white)
              }
              .shadow(color: .blue, radius: 10, x: 0, y: 5)
          }
          
          Button(action: {
            showHardMode.toggle()
          }) {
            RoundedRectangle(cornerRadius: 20)
              .fill(Color.gray)
              .frame(width: 200, height: 120)
              .overlay {
                Text("Hard")
                  .font(Font.custom("Bebas Neue", size: 28))
                  .foregroundColor(.black)
              }
              .shadow(color: .gray, radius: 10, x: 0, y: 5)
          }
        }
      }
      .padding()
      .background(Color.white)
      .cornerRadius(30)
      .shadow(color: .gray, radius: 20, x: 0, y: 10)
    }
    .fullScreenCover(isPresented: $showEasyMode, content: {
      GameView(mode: .easy)
    })
    .fullScreenCover(isPresented: $showHardMode, content: {
      GameView(mode: .hard)
    })
  }
}


#Preview {
  MenuView()
}
