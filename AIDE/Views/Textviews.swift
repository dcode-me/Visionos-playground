//
//  Textviews.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-14.
//

import SwiftUI

struct ImageTitle: View {
  var text: String
  var imageAsset: ImageAsset
  
  var body: some View {
    HStack(alignment: .center) {
      Text(text)
        .font(.headline)
        .bold()// Apply headline font style
      imageAsset.image
        .resizable() // Make the image resizable
        .scaledToFit() // Ensure the image fits well within the view
        .frame(width: 16, height: 16) // Specify the image size
      
    }
  }
}

struct subTitleText: View {
  var text: String
  var body: some View {
    Text(text).font(.caption)
  }
}

struct majorValueText: View {
  var text: String
  var body: some View {
    Text(text)
      .font(.extraLargeTitle)
  }
}

struct prefixText: View {
  var text: String
  var padding: CGFloat?
  var body: some View {
    if let verticalPadding = padding{
      Text(text)
        .font(.body)
        .fontWeight(.regular)
        .padding(.vertical, verticalPadding)
    }
    else {
      Text(text)
        .font(.body)
        .fontWeight(.regular)
    }
  }
}

struct minorValueText: View {
  var text: String
  var padding: CGFloat?
  var body: some View {
    if let verticalPadding = padding{
      Text(text)
        .font(.title2)
        .fontWeight(.regular)
        .foregroundColor(.gray)
        .padding(.vertical, verticalPadding)
    }
    else {
      Text(text)
        .font(.title2)
        .fontWeight(.regular)
        .foregroundColor(.gray)
        .fontWeight(.regular)
    }
  }
}





#Preview {
  VStack{
    ImageTitle(text: "Canada", imageAsset: .canada_flag)
    subTitleText(text: "In Millions")
    prefixText(text: "Prefix Text")
    majorValueText(text: "Major Value")
    minorValueText(text: "Minor Value")
  }
  
}
