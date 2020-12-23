//
//  GameView.swift
//  WerewolfSimulation-watch WatchKit Extension
//
//  Created by 叶絮雷 on 2020/11/22.
//

import SwiftUI

struct GameView: View {
    var config:GameConfig
    var body: some View {
        Text("Hello, World!")
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(config: GameConfig())
    }
}
