//
//  CardDetailView.swift
//  Cards
//
//  Created by Manu on 09/09/24.
//

import SwiftUI

struct CardDetailView: View {
    @EnvironmentObject var store: CardStore
    @Binding var card: Card
    var proxy: GeometryProxy?
    var viewScale: CGFloat  {
        guard let proxy else { return 1}
        return Settings.calculateScale(proxy.size)
    }
    
    var body: some View {
        ZStack {
            card.backgroundColor
                .onTapGesture {
                    store.selectedElement = nil
                }
            
            ForEach($card.elements, id: \.id) { $element in
                    CardElementView(element: element)
                        .overLay(element: element, isSelected: isSelected(element))
                
                    .elementContextMenu(card: $card, element: $element)
                    .resizableView(
                        transform: $element.transform,
                        viewScale: viewScale)
                    .frame(
                        width: element.transform.size.width,
                        height: element.transform.size.height)
                    .onTapGesture {
                        store.selectedElement = element
                    }
            }
        }
        .onDisappear{
            store.selectedElement = nil
        }
        .dropDestination(for: CustomTransfer.self) { items, location in
            print(location)
            Task {
                let offset = Settings.calculateDropOffset(
                  proxy: proxy,
                  location: location)
                card.addElements(from:items, at: offset)
            }
            return !items.isEmpty
        }
    }
    
    func isSelected(_ element: CardElement) -> Bool {
        store.selectedElement?.id == element.id
    }
}

struct CardDetailView_Previews: PreviewProvider {
    struct CardDetailPreview: View {
        @EnvironmentObject var store: CardStore
        var body: some View {
            CardDetailView(card: $store.cards[0])
        }
    }
    
    static var previews: some View {
        CardDetailPreview()
            .environmentObject(CardStore(defaultData: true))
    }
    
}

extension CardElementView {
    @ViewBuilder
    func overLay(element: CardElement, isSelected: Bool) -> some View {
        if let element = element as?  ImageElement, isSelected{
            if let frameIndex = element.frameIndex {
                let shape = Shapes.shapes[frameIndex]
                self
                    .overlay(shape.stroke(Settings.borderColor, lineWidth: Settings.borderWidth))
            }else {
                self
                    .border(Settings.borderColor, width: Settings.borderWidth)
            }
        }else {
            self
        }
    }
}




