//
//  CardView.swift
//  Cards
//
//  Created by Jake Abramson on 2/22/26.
//

import SwiftUI

struct CardView: View {
    var card: Card
    var frameWidth: CGFloat
    var frameHeight: CGFloat
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .fill(.white) //or foregroundStyle()
                .overlay{
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 2)
                }
            
            Text("\(card.suit.rawValue)\(card.type)")
                .font(Font.system(size: 50)) //alows you to change the font size
                .minimumScaleFactor(0.5) //squeeze together
                .lineLimit(1) //force on one line
        }
        .frame(width: frameWidth, height: frameHeight)
    }
}

#Preview {
    CardView(card: Card(suit: Suits.clubs, rank: .ace), frameWidth: 75, frameHeight: 150)
}
