//
//  TestView.swift
//  Jigsaw
//
//  Created by ANDELA on 20/04/2024.
//

import SwiftUI

struct TestView1: View {
  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 10) {
        Text("GeometryReader")
          .font(.title)
        Text("Buttons example")
          .font(.subheadline)
        
        HStack {
          Button("Button 1") {}
            .frame(width: geometry.size.width/3, height: 50)
            .background(.orange)
          Button("Button 2") {}
            .frame(width: geometry.size.width/3, height: 50)
            .background(.yellow)
          Button("Button 3") {}
            .frame(width: geometry.size.width/3, height: 50)
            .background(.green)
        }
      }
    }
  }
}

struct TestView: View {
  var body: some View {
    GeometryReader { geometry in
      VStack {
        Color.yellow
        ZStack {
          Rectangle()
            .foregroundColor(.blue)
          Circle()
            .foregroundColor(.white)
            .frame(
              width: geometry.size.width * 0.5,
              height: geometry.size.width * 0.5
            )
        }
        Color.green
      }
    }
  }
}


#Preview {
    TestView()
}
