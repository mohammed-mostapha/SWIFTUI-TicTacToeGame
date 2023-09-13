//
//  GameView.swift
//  SwiftUI-TicTacToeGame
//
//  Created by Mohamed Mostapha on 12/09/2023.
//

import SwiftUI
import CoreData


struct GameView: View {
    
    @StateObject private var vM = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: vM.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            GameSquareView(proxy: geometry)
                            
                            PlayerIndicator(systemImageName: vM.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            vM.processPlayerMove(for: i)
                        }
                        
                    }
                }
                Spacer()
            }
            
            .disabled(vM.isGameBoardDisabled)
            .padding()
            .alert(item: $vM.alertItem, content: { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: { vM.resetGame() }))
            })
        }
        
    }
}



enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

struct GameSquareView: View {
    
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(.red)
            .opacity(0.5)
            .frame(width: proxy.size.width/3 - 15, height: proxy.size.width/3 - 15)
    }
}

struct PlayerIndicator: View {
    
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}
