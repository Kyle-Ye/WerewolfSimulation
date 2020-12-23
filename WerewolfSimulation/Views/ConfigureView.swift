//
//  ConfigureView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/11/22.
//

import CoreMafia
import SwiftUI

struct ConfigureView: View {
    @ObservedObject var config: GameConfig
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass!

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
            Stepper(value: $config.werewolf, in: 0 ... 20) {
                Text("Werewolf: \(config.werewolf)")
            }
            Stepper(value: $config.villager, in: 0 ... 20) {
                Text("Villager: \(config.villager)")
            }
            Stepper(value: $config.seer, in: 0 ... 20) {
                Text("Seer: \(config.seer)")
            }
        }
    }

    var info2: some View {
        Group {
            Stepper(value: $config.hunter, in: 0 ... 20) {
                Text("Hunter: \(config.hunter)")
            }
            Stepper(value: $config.crow, in: 0 ... 20) {
                Text("Crow: \(config.crow)")
            }
            Stepper(value: $config.idiot, in: 0 ... 20) {
                Text("Idiot: \(config.idiot)")
            }
        }
    }

    var info3: some View {
        Group {
            Toggle("Witch: \(config.witch)", isOn: $config.withWitch)
            Toggle("Savior: \(config.savior)", isOn: $config.withSavior)
            Toggle("Secretwolf: \(config.secretwolf)", isOn: $config.withSecretwolf)
        }
    }

//    var info4: some View {
//        Group {
//            Stepper(value: $total, in: total - config.villager ... total + 1) {
//                Text("Total: \(total)")
//            }
//        }
//    }

    var body: some View {
        VStack {
            switch horizontalSizeClass {
            case .compact:
                VStack {
                    info1.padding()
                    info2.padding()
                    info3.padding()
                }
            case .regular:
                HStack { info1 }.padding()
                HStack { info2 }.padding()
                HStack { info3 }.padding()
            default:
                HStack { info1 }.padding()
                HStack { info2 }.padding()
                HStack { info3 }.padding()
            }
            if hasRound {
                Stepper(value: $config.round, in: 1000 ... 50000, step: 2000) {
                    Text("Round: \(config.round)")
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
