//
//  ModeItemView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/24.
//

import CoreMafia
import SwiftUI

struct ModeItemView: View {
    private var game: WerewolfGame
    private var mode: Mode
    init(mode: Mode) {
        self.mode = mode
        game = WerewolfGame(config: mode.config, rule: mode.rule)
    }

    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 2
        formatter.maximumFractionDigits = 5
        return formatter
    }

    @State private var stop = false
    @State var index = 0
    @State var winRates: Float = 0.0
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Citizen")
                    Text(formatter.string(from: NSNumber(value: winRates))!)
                    Text(winRates.description)
                }
                HStack {
                    Text("Wolf")
                    Text(formatter.string(from: NSNumber(value: 1 - winRates))!)
                    Text((1-winRates).description)
                }
            }
            Spacer()
            VStack {
                Text("Round: \(index)/\(mode.round)")
                Text(mode.hashValue.description)
            }
        }
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
                    if i % 50 == 0 {
                        DispatchQueue.main.async {
                            index = i
                            winRates = Float(wins) / Float(i)
                        }
                    }
                }
            }
        }
        .onDisappear {
            stop = true
        }
    }
}

struct ModeItemView_Previews: PreviewProvider {
    static var previews: some View {
        ModeItemView(mode: Mode())
    }
}
