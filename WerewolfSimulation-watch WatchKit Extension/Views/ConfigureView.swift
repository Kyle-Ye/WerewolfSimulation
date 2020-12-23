//
//  ConfigureView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/11/22.
//

import SwiftUI

struct ConfigureView: View {
    @ObservedObject var config: GameConfig
    @Binding var total: Int
    var hasRound: Bool

    init(config: GameConfig, hasRound: Bool = true) {
        self.config = config
        self.hasRound = hasRound
        _total = Binding(get: {
            config.werewolf + config.secretwolf +
                config.villager + config.seer +
                config.witch + config.savior +
                config.hunter + config.crow +
                config.idiot
        }, set: { value in
            config.villager = value - config.werewolf -
                config.secretwolf - config.seer -
                config.witch - config.savior -
                config.hunter - config.crow -
                config.idiot
        })
    }

    var info1: some View {
        Group {
            Stepper(value: $config.werewolf, in: 1 ... 20) {
                Text("Werewolf: \(config.werewolf)")
            }
            Stepper(value: $config.secretwolf, in: 0 ... 1) {
                Text("Secretwolf: \(config.secretwolf)")
            }
        }
    }

    var info2: some View {
        Group {
            Stepper(value: $config.villager, in: 1 ... 20) {
                Text("Villager: \(config.villager)")
            }
            Stepper(value: $config.seer, in: 0 ... 1) {
                Text("Seer: \(config.seer)")
            }
        }
    }

    var info3: some View {
        Group {
            Stepper(value: $config.witch, in: 0 ... 1) {
                Text("Witch: \(config.witch)")
            }
            Stepper(value: $config.savior, in: 0 ... 1) {
                Text("Savior: \(config.savior)")
            }
        }
    }

    var info4: some View {
        Group {
            Stepper(value: $config.hunter, in: 0 ... 1) {
                Text("Hunter: \(config.hunter)")
            }
            Stepper(value: $config.crow, in: 0 ... 1) {
                Text("Crow: \(config.crow)")
            }
        }
    }

    var info5: some View {
        Group {
            Stepper(value: $config.idiot, in: 0 ... 1) {
                Text("Idiot: \(config.idiot)")
            }
            Stepper(value: $total, in: 1 ... 50) {
                Text("Total: \(total)")
            }
        }
    }

    var body: some View {
        VStack {
            info1.padding()
            info2.padding()
            info3.padding()
            info4.padding()
            info5.padding()

            if hasRound {
                Stepper(value: $config.round, in: 1000 ... 50000, step: 2000) {
                    Text("round: \(config.round)")
                }
                .padding()
            }
        }
        .padding()
    }
}

struct ConfigureView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureView(config: GameConfig())
    }
}
