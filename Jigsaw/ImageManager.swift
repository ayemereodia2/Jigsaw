//
//  ImageManager.swift
//  Jigsaw
//
//  Created by ANDELA on 28/04/2024.
//

import Foundation
import SwiftUI

class ImageManager: ImageManagerProtocol {
  
  private let rowSplit:Int
  private let colSplit:Int
  private let isRandom:Bool

  
  init(rowSplit: Int, colSplit: Int, isRandom:Bool) {
    self.rowSplit = rowSplit
    self.colSplit = colSplit
    self.isRandom = isRandom
  }
  
  func generateImage() -> [Int:UIImage?] {
    let originalImage = UIImage(named: "black-woman-smiling")!
    let images = splitImageIntoParts(originalImage: originalImage, rows: self.rowSplit, columns: self.colSplit)
    return images
  }
  
  func splitImageIntoParts(originalImage: UIImage, rows: Int, columns: Int) -> [Int:UIImage?] {
    guard let cgImage = originalImage.cgImage else { return [:] }
      
      let imageWidth = originalImage.size.width
      let imageHeight = originalImage.size.height
      
      let partWidth = Int(imageWidth) / columns
      let partHeight = Int(imageHeight) / rows
      
     var images: [Int:UIImage?] = [:]
     var random = isRandom ? Array(0...(rows * columns) - 1).shuffled()
    : Array(0...(rows * columns) - 1)

      for row in 0..<rows {
          for column in 0..<columns {
              let x = column * partWidth
              let y = row * partHeight
              let cropRect = CGRect(x: x, y: y, width: partWidth, height: partHeight)
              if let croppedImage = cgImage.cropping(to: cropRect) {
                let key = isRandom ? random.removeLast() : random.removeFirst()
                if key == 0 {
                  images[0] = nil
                } else {
                  images[key] = UIImage(cgImage: croppedImage)
                }
              }
          }
      }
      
      return images
  }
}

protocol ImageManagerProtocol {
  func generateImage() -> [Int:UIImage?]
  func splitImageIntoParts(originalImage: UIImage, rows: Int, columns: Int) -> [Int:UIImage?]
}
