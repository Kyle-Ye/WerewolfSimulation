//
//  ConfigureView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/11/22.
//

import CoreMafia
import SwiftUI

struct ModeEditor: View {
    @ObservedObject var config: GameConfig
    @ObservedObject var rule: GameRule
    @State private var editRule: Bool = false
    @State private var editConfig: Bool = false

    var hasRound: Bool

    init(config: GameConfig, rule: GameRule, hasRound: Bool = true) {
        self.config = config
        self.rule = rule
        self.hasRound = hasRound
    }

    var body: some View {
        VStack {
            HStack {
                NavigationLink(
                    destination: ConfigureEditor(config: config)
                        .toggleStyle(SwitchToggleStyle(tint: .accentColor)),
                    isActive: $editConfig,
                    label: {
                        Button(action: {
                            editConfig.toggle()
                        }, label: {
                            Spacer()
                            Text("Edit Config")
                            Spacer()
                        })
                            .padding()
                            .foregroundColor(.primary)
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    })
                NavigationLink(
                    destination: RuleEditor(rule: rule)
                        .toggleStyle(SwitchToggleStyle(tint: .accentColor)),
                    isActive: $editRule,
                    label: {
                        Button(action: {
                            editRule.toggle()
                        }, label: {
                            Spacer()
                            Text("Edit Rule")
                            Spacer()
                        })
                            .padding()
                            .foregroundColor(.primary)
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    })
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
        ModeEditor(config: GameConfig(), rule: GameRule())
    }
}

extension GameConfig: CustomStringConvertible {
    public var description: String {
        "(\(werewolf),\(villager),\(seer)"
    }
}
