//
//  SingleGame.swift
//  WerewolfSimulation-watch WatchKit Extension
//
//  Created by 叶絮雷 on 2020/11/22.
//

import SwiftUI

struct SingleGame: View {
    @StateObject var config = GameConfig()
    @State private var show = false
    var body: some View {
        VStack {
            ConfigureView(config: config,hasRound: false)
            Button("Start Single Game") {
                show.toggle()
            }
        }
        .sheet(isPresented: $show, content: {
            GameView(config: config)
        })
    }
}

struct SingleGame_Previews: PreviewProvider {
    static var previews: some View {
        SingleGame()
    }
}
