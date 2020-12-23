//
//  SingleGame.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/11/22.
//

import CoreMafia
import SwiftUI

struct SingleGame: View {
    @StateObject var mode = Mode()
    @State private var show = false
    var body: some View {
        ScrollView {
            ModeEditor(mode:mode, hasRound: false)
            NavigationLink(
                destination: GameView(mode: mode),
                isActive: $show,
                label: {
                    Button(action: {
                        show.toggle()
                    }, label: {
                        Spacer()
                        Text("Start Single Game")
                        Spacer()
                    }).padding()
                        .foregroundColor(.primary)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
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
