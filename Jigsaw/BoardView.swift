//
//  ContentView.swift
//  Jigsaw
//
//  Created by ANDELA on 19/04/2024.
//

import SwiftUI
import CoreGraphics

struct BoardView: View {
  @Bindable var viewModel:BoardViewModel
  private let borderWidth:CGFloat = 1
  @State private var isProcessingDrag = false
  
    var body: some View {
      GeometryReader { proxy in
        VStack(spacing: 1) {
          ForEach(0..<viewModel.numberOfColums) { row in
                Group {
                    HStack(spacing: 1) {
                      ForEach(0..<viewModel.numberOfRows) { column in
                          GeometryReader { innerProxy in
                            // Calculate the index based on row and column
                            let index = row * viewModel.numberOfRows + column

                            UnitView(row:row, column:column, dataImage: viewModel.setImage(index: index))
                              .frame(width: viewModel.gridItemWidth, height: viewModel.gridItemHeight)
                              .onAppear {
                                let pointX = innerProxy.frame(in: .global).minX
                                let pointY = innerProxy.frame(in: .global).minY

                                viewModel.pointRect["\(row)\(column)"] = CGRect(x: pointX, y: pointY, width: viewModel.gridItemWidth, height: viewModel.gridItemHeight)
                                
                              }
                              .border(.yellow)
                          }
                          .frame(width: viewModel.gridItemWidth, height: viewModel.gridItemHeight)
                        }
                        Spacer()
                    }
                }
            }
            
        }
        .frame(width: proxy.size.width, height: proxy.size.height)
        .gesture(
          DragGesture()
            .onChanged { startValue in
              guard !isProcessingDrag else { return } 
              // Check if drag is already being processed
                isProcessingDrag = true
              let point = CGPoint(x: startValue.location.x , y: startValue.location.y + viewModel.gridItemWidth)
              for (key,rect) in viewModel.pointRect {
                if rect.contains(point) {
                  let positions = key.map { Int(String($0)) ?? 0 }
                  viewModel.draggedRowIndex = positions[0]
                  viewModel.draggedColumnIndex = positions[1]
                  break
                }
              }
            }
            .onEnded { endValue in
              isProcessingDrag = false
        
              let point = CGPoint(x: endValue.location.x , y: endValue.location.y + viewModel.gridItemWidth)

              for (key,rect) in viewModel.pointRect {
                if rect.contains(point) {
                  let positions = key.map { Int(String($0)) ?? 0 }
                  let row = positions[0]
                  let col = positions[1]
                  viewModel.moveItem(endValue, newRow: row, newColumn: col)
                  break
                }
              }
              
              
            }
        )
      }
      .frame(width: viewModel.boardWidth)
      .frame(height: viewModel.boardHeight)
    }
}

//#Preview {
//  BoardView()
//}
