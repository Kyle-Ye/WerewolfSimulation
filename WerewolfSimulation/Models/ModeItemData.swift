//
//  ModeItemData.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/24.
//

import Combine
import CoreMafia
import Foundation

struct SlowDataStore {
    static func getRate(_ mode: Mode) -> AnyPublisher<Bool, Never> {
        let game = WerewolfGame(config: mode.config, rule: mode.rule)

        return (1 ... mode.round).indices.publisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map { _ in
                game.autoplay()
                let result = game.result
                game.replay()
                return result == 1
            }
            .eraseToAnyPublisher()
    }
}

final class ModeItemData: ListDataItem, ObservableObject {
    var content: Mode
    init(content: Mode) {
        self.content = content
    }

    var dataIsFetched: Bool {
        process == content.round
    }

    var wins = 0
    @Published var process: Int = 0
    @Published var rate: Double = 0.0

    private var dataPublisher: AnyCancellable?

    func fetchData() {
        if !dataIsFetched {
            dataPublisher = SlowDataStore.getRate(content)
                .receive(on: DispatchQueue.main)
                .sink { win in
                    self.wins += win ? 1 : 0
                    self.process += 1
                    self.rate = Double(self.wins) / Double(self.process)
                }
        }
    }
}
