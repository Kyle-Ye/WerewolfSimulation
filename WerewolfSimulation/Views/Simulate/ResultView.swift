//
//  ResultView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/10/4.
//

import CoreMafia
import SwiftUI
import SwiftUICharts

struct ResultView: View {
    @Environment(\.presentationMode) private var presentationMode
    private var game: WerewolfGame
    private var mode: Mode
    init(mode:Mode) {
        self.mode = mode
        game = WerewolfGame(config: mode.config, rule: mode.rule)
    }

    @State var winRates: [Double] = []
    @State var stop: Bool = false

    var body: some View {
        VStack {
            LineView(data: winRates, title: "The win rates of citizen group", valueSpecifier: "%.5 f")
                .onAppear {
                    DispatchQueue.global().async {
                        var wins = 0
                        for i in 1 ... mode.round {
                            if stop {
                                return
                            }
                            game.autoplay()
                            if game.result == 1 {
                                wins += 1
                            }
                            game.replay()
                            if i & 20 == 0 {
                                let rate = Double(wins) / Double(i)
                                DispatchQueue.main.async {
                                    winRates.append(rate)
                                }
                            }
                        }
                    }
                }
            Spacer()
            Button(action: {
                stop = true
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Done")
            })
                .padding()
        }
        .padding()
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(mode: Mode())
    }
}
