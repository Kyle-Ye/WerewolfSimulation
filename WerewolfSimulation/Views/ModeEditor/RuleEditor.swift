//
//  RuleEditor.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/23.
//

import CoreMafia
import SwiftUI

struct RuleEditor: View {
    @ObservedObject var rule: GameRule

    var body: some View {
        Form {
            Section(header: Text("Game")) {
                Toggle("Special Claim", isOn: $rule.willSpecialClaim)
                Toggle("Seer White List Claim", isOn: $rule.willSeerWhiteListClaim)
                Toggle("Savior White List Claim", isOn: $rule.willSaviorWhiteListClaim)
                Toggle("Witch White List Claim", isOn: $rule.willWitchWhiteListClaim)
            }
            Section(header: Text("Savior")) {
                Picker(selection: $rule.saviorRule, label: Text("Savior rule"), content: {
                    ForEach(GameRule.SaviorRule.allCases) { rule in
                        Text(rule.rawValue).tag(rule)
                    }
                })
            }
            Section(header: Text("witch")) {
                Stepper("Antidote: \(rule.witchAntidote)", value: $rule.witchAntidote, in: 0 ... 5)
                Stepper("Poison: \(rule.witchPoison)", value: $rule.witchPoison, in: 0 ... 5)
            }
        }
    }
}

struct RuleEditor_Previews: PreviewProvider {
    static var previews: some View {
        RuleEditor(rule: GameRule())
    }
}
