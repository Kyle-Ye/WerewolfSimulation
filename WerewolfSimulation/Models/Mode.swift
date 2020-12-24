//
//  Mode.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/23.
//

import Combine
import CoreMafia
import Foundation

class Mode: ObservableObject {
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

extension Mode: Hashable {
    static func == (lhs: Mode, rhs: Mode) -> Bool {
        return (lhs.round == rhs.round) && (lhs.config == rhs.config) && (lhs.rule == rhs.rule)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(round)
        hasher.combine(config)
        hasher.combine(rule)
    }
}

extension GameConfig: Hashable {
    public static func == (lhs: GameConfig, rhs: GameConfig) -> Bool {
        return lhs.werewolf == rhs.werewolf &&
            lhs.villager == rhs.villager &&
            lhs.seer == rhs.seer &&
            lhs.hunter == rhs.hunter &&
            lhs.crow == rhs.crow &&
            lhs.idiot == rhs.idiot &&
            lhs.withWitch == rhs.withWitch &&
            lhs.withSavior == rhs.withSavior &&
            lhs.withSecretwolf == rhs.withSecretwolf
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(werewolf)
        hasher.combine(villager)
        hasher.combine(seer)
        hasher.combine(hunter)
        hasher.combine(crow)
        hasher.combine(idiot)
        hasher.combine(withWitch)
        hasher.combine(withSavior)
        hasher.combine(withSecretwolf)
    }
}

extension GameRule: Hashable {
    public static func == (lhs: GameRule, rhs: GameRule) -> Bool {
        return lhs.willSpecialClaim == rhs.willSpecialClaim &&
            lhs.willSeerWhiteListClaim == rhs.willSeerWhiteListClaim &&
            lhs.willSaviorWhiteListClaim == rhs.willSaviorWhiteListClaim &&
            lhs.willWitchWhiteListClaim == rhs.willWitchWhiteListClaim &&
            lhs.saviorRule == rhs.saviorRule &&
            lhs.witchAntidote == rhs.witchAntidote &&
            lhs.witchPoison == rhs.witchPoison
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(willSpecialClaim)
        hasher.combine(willSeerWhiteListClaim)
        hasher.combine(willSaviorWhiteListClaim)
        hasher.combine(willWitchWhiteListClaim)
        hasher.combine(saviorRule)
        hasher.combine(witchAntidote)
        hasher.combine(witchPoison)
    }
}

extension Mode {
    func copy() -> Mode {
        let newMode = Mode()
        newMode.round = round
        newMode.config = config.copy()
        newMode.rule = rule.copy()
        return newMode
    }
}

extension GameConfig {
    func copy() -> GameConfig {
        let newConfig = GameConfig()
        newConfig.werewolf = werewolf
        newConfig.villager = villager
        newConfig.seer = seer
        newConfig.hunter = hunter
        newConfig.crow = crow
        newConfig.idiot = idiot
        newConfig.withWitch = withWitch
        newConfig.withSavior = withSavior
        newConfig.withSecretwolf = withSecretwolf
        return newConfig
    }
}

extension GameRule {
    func copy() -> GameRule {
        let newRule = GameRule()
        newRule.willSpecialClaim = willSpecialClaim
        newRule.willSeerWhiteListClaim = willSeerWhiteListClaim
        newRule.willSaviorWhiteListClaim = willSaviorWhiteListClaim
        newRule.willWitchWhiteListClaim = willWitchWhiteListClaim
        newRule.saviorRule = saviorRule
        newRule.witchAntidote = witchAntidote
        newRule.witchPoison = witchPoison
        return newRule
    }
}


extension GameConfig: CustomStringConvertible {
    public var description: String {
        "(\(werewolf),\(villager),\(seer),\(hunter),\(crow),\(idiot),\(withWitch),\(withSavior),\(withSecretwolf))"
    }
}

extension GameRule: CustomStringConvertible {
    public var description: String {
        "(\(willSpecialClaim),\(willSeerWhiteListClaim),\(willSaviorWhiteListClaim),\(willWitchWhiteListClaim),\(saviorRule),\(witchAntidote),\(witchPoison))"
    }
}
