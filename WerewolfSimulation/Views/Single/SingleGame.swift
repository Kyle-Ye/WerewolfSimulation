//
//  SingleGame.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/11/22.
//

import SwiftUI
import CoreMafia

struct SingleGame: View {
    @StateObject var config = GameConfig()
    @State private var show = false
    var body: some View {
        ScrollView {
            ConfigureView(config: config, hasRound: false)
            NavigationLink(
                destination: GameView(config: config),
                isActive: $show,
                label: {
                    Button("Start Single Game") {
                        show.toggle()
                    }
                })
                .padding()
        }
    }
}

struct SingleGame_Previews: PreviewProvider {
    static var previews: some View {
        SingleGame()
    }
}
