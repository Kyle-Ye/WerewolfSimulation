//
//  ConfigureEditor.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/23.
//

import CoreMafia
import SwiftUI

struct ConfigureEditor: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass!
    @ObservedObject var config: GameConfig
    @Binding var total: Int
    init(config: GameConfig) {
        self.config = config
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

    var body: some View {
        Form{
            switch horizontalSizeClass {
            case .compact:
                Section { info1.padding() }
                Section { info2.padding() }
                Section { info3.padding() }
                
            case .regular:
                Section { HStack { info1 }.padding() }
                Section { HStack { info2 }.padding() }
                Section { HStack { info3 }.padding() }
            default:
                Section { info1.padding() }
                Section { info2.padding() }
                Section { info3.padding() }
            }
            Stepper(value: $total, in: total - config.villager ... total + 1) {
                Text("Total: \(total)")
            }
            .padding()
        }
        
    }
}

struct ConfigureEditor_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureEditor(config: GameConfig())
    }
}
