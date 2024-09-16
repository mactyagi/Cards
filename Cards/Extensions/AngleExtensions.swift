//
//  AngleExtension.swift
//  Cards
//
//  Created by manukant tyagi on 14/09/24.
//

import SwiftUI
extension Angle: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let degrees = try container.decode(Double.self, forKey: .degrees)
        self.init(degrees: degrees)
    }
    
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(degrees, forKey: .degrees)
    }
    
    enum CodingKeys: CodingKey {
        case degrees
    }
}
