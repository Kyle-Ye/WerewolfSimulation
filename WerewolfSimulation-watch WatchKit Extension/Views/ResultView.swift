//
//  ResultView.swift
//  WerewolfSimulation-watch WatchKit Extension
//
//  Created by 叶絮雷 on 2020/11/21.
//
import CoreMafia
import SwiftUI
import SwiftUICharts

struct ResultView: View {
    @Environment(\.presentationMode) private var presentationMode
    var config:GameConfig

    @State var winRates: [Double] = []

    var body: some View {
        ScrollView {
            Text("Win rates - Citizen")
                .bold()
            LineView(data: winRates, title: nil, valueSpecifier: "%.5f")
                .onAppear {
                    DispatchQueue.global().async {
                        var wins = 0
                        for i in 1 ... config.round {
                            let game = WerewolfGame(config: config)
                            game.autoplay()
                            if game.result == 1 {
                                wins += 1
                            }
                            if i & 20 == 0 {
                                let rate = Double(wins) / Double(i)
                                DispatchQueue.main.async {
                                    winRates.append(rate)
                                    //                                if winRates.count > 50{
                                    //                                    winRates.removeFirst()
                                    //                                }
                                }
                            }
                        }
                    }
                }
        }
    }
}


struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(config: GameConfig())
    }
}
