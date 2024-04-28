//
//  BoardViewModel.swift
//  Jigsaw
//
//  Created by ANDELA on 28/04/2024.
//

import SwiftUI

// using the new swift @observable macro
@Observable class BoardViewModel {
  var draggedRowIndex: Int = 0
  var draggedColumnIndex: Int = 0
  private(set) var boardWidth:CGFloat
  private(set) var boardHeight:CGFloat
  var pointRect = [String:CGRect]()
  private let imageManager: ImageManagerProtocol
  private var images:[Int:UIImage?] = [:]
  var image:UIImage = UIImage()
  
  private let rows: Int
  private let columns:Int
  
  init(rows: Int, cols: Int, boardWidth:CGFloat, boardHeight:CGFloat, imageManager:ImageManagerProtocol) {
    
    self.boardWidth = boardWidth
    self.boardHeight = boardHeight
    self.rows = rows
    self.columns = cols
    self.imageManager = imageManager
    generateImage()
  }
  
  func generateImage() {
    images = imageManager.generateImage()
  }
  
  
  
  var gridItemWidth:CGFloat {
    //boardwidth divided by numOfCol
    boardWidth / CGFloat(columns)
  }
  
  var gridItemHeight:CGFloat {
    // board heigth divided by numOfRow
    boardHeight / CGFloat(numberOfRows)
  }
  
  var numberOfRows:Int {
    rows
  }
  
  var numberOfColums:Int {
    columns
  }
  
  func getBoardHeight() -> CGFloat {
    boardHeight
  }
  
  func getBoardWidth() -> CGFloat {
    boardWidth
  }
  
  
  func setImage(index:Int) -> UIImage? {
    if let valueImage = images[index] {
      return valueImage
    }
    return nil
  }
  
  
  func moveItem(_ value: DragGesture.Value, newRow: Int, newColumn:Int) {
    let oldColumn = draggedColumnIndex
    let oldRow = draggedRowIndex
    
    let rowDistance = abs(newRow - oldRow)
    let columnDistance = abs(newColumn - oldColumn)
    
    // Check if the distance between grid items is 1 (either in rows or columns)
    if rowDistance == 1 && columnDistance == 0 || rowDistance == 0 && columnDistance == 1 {
      
      let newIndex = newRow * self.numberOfRows + newColumn
      let oldIndex = draggedRowIndex * self.columns + draggedColumnIndex
      if let nextImage = images[oldIndex], images[newIndex] == nil {
        images[newIndex] = nextImage
        images[oldIndex] = nil
      }
      
    } else {
      // Distance is not 1, so do not perform movement
      print("Invalid movement: Distance between grid items is not 1")
    }
  }
  
}
