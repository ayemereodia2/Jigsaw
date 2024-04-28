//
//  GameView.swift
//  Jigsaw
//
//  Created by ANDELA on 28/04/2024.
//

import SwiftUI

struct GameView: View {
  @State var mode:PlayState
  @Environment(\.presentationMode) var presentationMode
  @State private var showAlert = false
  @State private var showFinal = false
  @Bindable private var easyViewModel = BoardViewModel(rows: 3, cols: 3, boardWidth: 400, boardHeight: 500, imageManager: ImageManager(rowSplit: 3, colSplit: 3, isRandom: true))
  
  @Bindable private var hardViewModel = BoardViewModel(rows: 5, cols: 5, boardWidth: 400, boardHeight: 620, imageManager: ImageManager(rowSplit: 5, colSplit: 5, isRandom: true))
  
  var body: some View {
    LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
      .edgesIgnoringSafeArea(.all)
      .overlay(
        VStack {
          Rectangle()
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.clear)
            .overlay {
              Text("You are awesome!!!")
                .font(Font.custom("Bebas Neue", size: 30))
                .foregroundStyle(.white)
            }
          switch mode {
          case .easy:
            BoardView(viewModel: easyViewModel)
          case .hard:
            BoardView(viewModel: hardViewModel)
          }
          HStack {
            Button {
              showAlert = true
            }label: {
              Text("Exit Game")
                .font(Font.custom("Bebas Neue", size: 18))
                .foregroundColor(.black)
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
            }
            Spacer()
            Button {
              showFinal = true
            }label: {
              Text("see Final Picture")
                .font(Font.custom("Bebas Neue", size: 20))
                .foregroundColor(.black)
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
            }
          }
          .frame(height: 80)
          .padding()
        }
          .alert(isPresented: $showAlert) {
            Alert(
              title: Text("Exit Game"),
              message: Text("Are you sure you want to exit game"),
              primaryButton: .cancel(Text("Cancel")),
              secondaryButton: .destructive(Text("Yes"), action: {
                presentationMode.wrappedValue.dismiss()
              })
            )
          }
          .sheet(isPresented: $showFinal) {
            // TODO pass message to viewModel to Image manager
            let easyShow = BoardViewModel(rows: 3, cols: 3, boardWidth: 400, boardHeight: 500, imageManager: ImageManager(rowSplit: 3, colSplit: 3, isRandom: false))
            
             let hardShow = BoardViewModel(rows: 5, cols: 5, boardWidth: 400, boardHeight: 620, imageManager: ImageManager(rowSplit: 5, colSplit: 5, isRandom: false))
            switch mode {
            case .easy:
              BoardView(viewModel: easyShow)
            case .hard:
              BoardView(viewModel: hardShow)
            }
          }
      )
  }
}

#Preview {
  GameView(mode: .easy)
}


enum PlayState {
  case easy
  case hard
}
