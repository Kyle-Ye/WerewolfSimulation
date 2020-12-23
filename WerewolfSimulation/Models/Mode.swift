//
//  Mode.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/23.
//

import CoreMafia
import Foundation
import Combine

class Mode:ObservableObject {
    var config: GameConfig = GameConfig()
    var rule: GameRule = GameRule()
    @Published var round: Int = 1000
    
    private var anyCancellable1: AnyCancellable?
    private var anyCancellable2: AnyCancellable?

    init() {
        anyCancellable1 = config.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        anyCancellable2 = rule.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
}
