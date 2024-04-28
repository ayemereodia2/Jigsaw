//
//  UnitView.swift
//  Jigsaw
//
//  Created by ANDELA on 28/04/2024.
//

import SwiftUI

struct UnitView: View {
  let row:Int
  let column:Int
  let dataImage: UIImage?
  
  var body: some View {
    ZStack {
        if let image = dataImage {
            GeometryReader { geometry in
              Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
            }
        } else {
          EmptyView()
        }
    }
  }

}
