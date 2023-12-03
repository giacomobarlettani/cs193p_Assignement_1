//
//  ContentView.swift
//  cs193p_Assignement
//
//  Created by Giacomo Barlettani on 03/12/23.
//

import SwiftUI

struct ContentView: View {
    
    //Variables
    
    let emojis:[String] = ["👻", "🐶", "🐹", "🐼", "🐵", "🐳", "🐢", "🕸"]
    @State var cardCount = 4
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                card
            }
            
            
            Spacer()
            
            cardadjuster
            
            
        }.padding()
        
    }
    
    var cardadjuster: some View {
        
        HStack {
            
            cardRemover
            
            Spacer()
            
            cardAdder
        }
        
    }
    
    var card: some View {
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) {index in
                CardView(text: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            
        }
        
    }
    var cardRemover: some View {
        
        cardAdjuster(by: -1, symbol: "minus.circle.fill")
   
        
    }
    
    var cardAdder: some View {
        
        cardAdjuster(by: +1, symbol: "plus.circle.fill")
    }
    
    func cardAdjuster(by offset:Int, symbol:String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
                .font(.largeTitle)
        }).disabled(cardCount + offset < 1 || cardCount + offset > emojis.count )
    }
    
}



struct CardView: View {
    
    var text:String
    var textColor:Color = Color.white
    var frontColor:Color = Color("bisque")
    var backColor:Color = Color("coral")
    @State var isFaceUp:Bool = true
    
    
    var body: some View {
        
        ZStack {
            
            if isFaceUp {
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(frontColor)
                    .overlay(alignment: .bottomTrailing) {
                        RoundedRectangle(cornerRadius: 20)
                            .trim(from: 0, to: 0.25)
                        //                            .scale(1, anchor: .bottomTrailing)
                            .foregroundColor(backColor)
                    }
                    .overlay{
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 2)
                            .foregroundColor(backColor)
                    }
                Text(text)
                    .font(.largeTitle)
                
            }else {
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(backColor)
                Text(text)
                    .font(.largeTitle)
                    .opacity(0)
                
            }
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
    
    
    
    
}






















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
