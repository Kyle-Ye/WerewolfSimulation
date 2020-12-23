//
//  GameView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/11/22.
//

import CoreMafia
import SwiftUI

struct GameView: View {
    // MARK: Body
    @ObservedObject private var game: WerewolfGame

    init(mode:Mode) {
        game = WerewolfGame(config: mode.config,rule: mode.rule)
    }

    var body: some View {
        ScrollView {
            BasicView()
                .padding(20)
            Divider()
            HistoryLogView()
                .padding(20)
        }
        .navigationTitle("Day \(game.time.round) - \(game.time.time.rawValue)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            toolBarContent()
        })
    }

    // MARK: - Basic View

    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150, maximum: 300), spacing: 10),
    ]
    @State private var basic = true

    private func BasicView() -> some View {
        DisclosureGroup(
            isExpanded: $basic,
            content: {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 18,
                    pinnedViews: [.sectionHeaders, .sectionFooters]) {
                    ForEach(game.players) { player in
                        PlayerCardView(player: player)
                    }
                }
                if game.result != 0 {
                    Text("🏆\(game.resultString)")
                        .font(.largeTitle)
                }
            },
            label: { Text("Basic View").font(.title).padding(.bottom, 10) }
        )
    }

    // MARK: - History Log View

    @State private var log = false
    @State private var logValue = 0.0
    var intLogValue: Int {
        Int(logValue)
    }

    private func HistoryLogView() -> some View {
        return DisclosureGroup(
            isExpanded: $log,
            content: {
                if game.logger.count > 1 {
                    Slider(
                        value: $logValue,
                        in: 0 ... Double(game.logger.count - 1),
                        step: 1,
                        onEditingChanged: { _ in
                            logValue = round(logValue)
                        },
                        minimumValueLabel: Text("1"),
                        maximumValueLabel: Text("\(game.logger.count)")
                    ) {
                        Text("History")
                    }
                }

                GroupBox(label: Text("Day \(intLogValue / 2 + 1) - \(intLogValue % 2 == 0 ? "day" : "night")")) {
                    VStack(alignment: .leading) {
                        ForEach(game.logger[intLogValue], id: \.self) { logItem in
                            Text(logItem)
                        }
                    }
                }
            },
            label: { Text("History Log").font(.title).padding(.bottom, 10) }
        )
    }

    // MARK: - toolBar Content

    @State private var pause = true

    private func toolBarContent() -> some View {
        HStack(spacing: 20) {
            Button(action: {
                pause = true
                logValue = 0
                game.replay()
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
                    .font(.title2)
            })
            Button(action: {
                pause.toggle()
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    game.play()
                    logValue = Double(game.logger.count - 1)
                    if game.result != 0 {
                        pause = true
                    }
                    if pause {
                        timer.invalidate()
                    }
                }
            }, label: {
                Image(systemName: pause ? "play.circle" : "pause.circle")
                    .font(.title2)
            })
                .disabled(game.result != 0)
            Button(action: {
                pause = true
                game.play()
                logValue = Double(game.logger.count - 1)
            }, label: {
                Image(systemName: "forward.frame")
                    .font(.title2)
            })
                .disabled(game.result != 0)
            Button(action: {
                pause = true
                game.autoplay()
                logValue = Double(game.logger.count - 1)
            }, label: {
                Image(systemName: "forward.end.alt")
                    .font(.title2)
            })
                .disabled(game.result != 0)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationLink(
                destination: GameView(mode:Mode()),
                isActive: .constant(true),
                label: {
                    Text("")
                })
        }
    }
}
