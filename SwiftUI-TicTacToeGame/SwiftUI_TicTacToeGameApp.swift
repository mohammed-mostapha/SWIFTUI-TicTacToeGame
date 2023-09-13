//
//  SwiftUI_TicTacToeGameApp.swift
//  SwiftUI-TicTacToeGame
//
//  Created by Mohamed Mostapha on 12/09/2023.
//

import SwiftUI

@main
struct SwiftUI_TicTacToeGameApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            GameView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
