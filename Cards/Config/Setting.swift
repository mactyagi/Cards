//
//  Setting.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import SwiftUI

enum Settings {
    static let cardSize = CGSize(width: 1300, height: 2000)
    static let thumbnailSize = CGSize(width: 150, height: 250)
    static let defaultElementSize = CGSize(width: 250, height: 180)
    static let borderColor: Color = .blue
    static let borderWidth: CGFloat = 5
}


extension Settings {
  static func calculateDropOffset(
    proxy: GeometryProxy?,
    location: CGPoint
  ) -> CGSize {
    guard
      let proxy,
      proxy.size.width > 0 && proxy.size.height > 0
    else { return .zero }

    // `frame` is a CGRect bounding the whole area including margins
    // surrounding the card
    /*
      The frame is in *global* coordinates.
      To illustrate what a coordinate space is, all card offsets are saved
      with the origin being at the center of the card.
      The origin is location (0, 0).
      However, `location` is in screen coordinates,
      where the origin is at the top left of the screen.
      So you must convert from “screen space” to “card space”.
      */
    let frame = proxy.frame(in: .global)

    // size is the calculated card size without margins
    let size = proxy.size

    // margins are the frame around the card
    // plus the frame's origin, if the frame is inset
    let leftMargin = (frame.width - size.width) * 0.5 + frame.origin.x
    let topMargin = (frame.height - size.height) * 0.5 + frame.origin.y

    // location is in screen coordinates
    // convert location from screen space to card space
    // top left of the screen is the old origin
    // top left of the card is the new origin
    var cardLocation = CGPoint(x: location.x - leftMargin, y: location.y - topMargin)

    // convert cardLocation into the fixed card coordinate space
    // so that the location is in 1300 x 2000 space
    cardLocation.x = cardLocation.x / size.width * Settings.cardSize.width
    cardLocation.y = cardLocation.y / size.height * Settings.cardSize.height

    // calculate the offset where 0, 0 is at the center of the card
    let offset = CGSize(
      width: cardLocation.x - Settings.cardSize.width * 0.5,
      height: cardLocation.y - Settings.cardSize.height * 0.5)
    return offset
  }
}
