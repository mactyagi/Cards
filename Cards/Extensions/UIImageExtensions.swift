//
//  UIImageExtensions.swift
//  Cards
//
//  Created by manukant tyagi on 12/09/24.
//

import SwiftUI

extension UIImage : Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { image in
            UIImage(data:image) ?? errorImage
        }
    }
    
    public static var errorImage: UIImage {
        UIImage.error
    }
}

