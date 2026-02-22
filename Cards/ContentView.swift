//
//  ContentView.swift
//  Cards
//
//  Created by Jake Abramson on 2/22/26.
//

import SwiftUI

enum Suits: String, CaseIterable {
    case hearts = "❤️"
    case diamonds = "♦️"
    case clubs = "♣️"
    case spades = "♠️"
}

enum Rank: Int, CaseIterable{
    case ace = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case jack = 11
    case queen = 12
    case king = 13
    
    var type: String{
        switch self{
        case .ace: return "A"
        case .jack: return "J"
        case .queen: return "Q"
        case .king: return "K"
        default: return "\(self.rawValue)"
        }
    }
    
}

struct Card: Identifiable {
    let id = UUID().uuidString //automatically puts unique value
    
    var suit: Suits
    var rank: Rank
    
    var type: String {rank.type}
    var value: Int {rank.rawValue}
    
    func printCard() {
        print("\(suit.rawValue)\(type) has a value \(value)")
    }
}

struct ContentView: View {
    @State private var cards: [Card] = []
    @State private var selectedCard = Card(suit: .hearts, rank: .queen)
    @State private var playerHand: [Card] = []
    
    var body: some View {
        VStack {
            Text("Cards in Deck: \(cards.count)")
                .font(.largeTitle)
                .fontWeight(.black)
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                    ForEach(cards) { card in
                        ZStack{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.white) //or foregroundStyle()
                                .overlay{
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.gray, lineWidth: 2)
                                }
                            
                            Text("\(card.suit.rawValue)\(card.type)")
                                .font(Font.system(size: 20)) //alows you to change the font size
                                .minimumScaleFactor(0.5) //squeeze together
                                .lineLimit(1) //force on one line
                        }
                        .frame(width: 50, height: 75)
                    }
                }
            }
            
            
            CardView(card: selectedCard, frameWidth: 75, frameHeight: 150)

            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                    ForEach(playerHand){playerCard in
                        CardView(card: playerCard, frameWidth: 55 , frameHeight: 100)
//                        ZStack{
//                            RoundedRectangle(cornerRadius: 5)
//                                .fill(.white) //or foregroundStyle()
//                                .overlay{
//                                    RoundedRectangle(cornerRadius: 5)
//                                        .stroke(.gray, lineWidth: 2)
//                                }
//                            
//                            Text("\(playerCard.suit.rawValue)\(playerCard.type)")
//                                .font(Font.system(size: 20)) //alows you to change the font size
//                                .minimumScaleFactor(0.5) //squeeze together
//                                .lineLimit(1) //force on one line
//                        }
//                        .frame(width: 50, height: 75)
                    }
                }
            }
            
        }
        .padding()
        .onAppear{
            guard cards.isEmpty else {return}
            for rank in Rank.allCases{ // go through all 13 ranks
                for suit in Suits.allCases { // go throuugh all 4 suits
                    cards.append(Card(suit: suit, rank: rank))
                }
            }
            randomize()
            //cards.forEach{$0.printCard()}
        }
        Button("Reset"){
            for _ in 0...4{
                cards.append(playerHand.removeLast())
            }
            cards.append(selectedCard)
            randomize()
        }
        .tint(.red)
        .buttonStyle(.borderedProminent)
        .font(.title2)
    }
    func randomize(){
        cards.shuffle()
        selectedCard = cards.removeLast()
        for _ in 0...4{
            playerHand.append(cards.removeLast())
        }
    }
}



#Preview {
    ContentView()
}
