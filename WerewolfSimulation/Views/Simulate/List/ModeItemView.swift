//
//  ModeItemView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/24.
//

import CoreMafia
import SwiftUI

struct ModeItemView: DynamicListRow {
    init(item: ModeItemData) {
        self.item = item
    }

    @ObservedObject var item: ModeItemData
    @State var animatedAmount: Double?
    let graphAnimation = Animation.interpolatingSpring(stiffness: 30, damping: 8)

    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 3
        formatter.maximumFractionDigits = 2
        return formatter
    }

    @State private var stop = false
    @State var index = 0

    var body: some View {
        HStack {
            VStack {
                Text("Citizen")
                    .fixedSize()
                Spacer()
                Text("Wolf")
                    .fixedSize()
            }
            Divider()

            VStack {
                HStack {
                    GraphBar(amount: item.rate, animatedAmount: $animatedAmount)
                    Text(formatter.string(from: NSNumber(value: item.rate))!)
                        .fixedSize()
                }
                HStack {
                    GraphBar(amount: 1 - item.rate, animatedAmount: $animatedAmount, minus: true)
                    Text(formatter.string(from: NSNumber(value: 1 - item.rate))!)
                }
            }
            VStack {
                Text("Round: \(item.progress)/\(item.content.round)")
                Text(item.content.config.description)
                Text(item.content.rule.description)
            }
        }
        .onReceive(self.item.$rate) { rate in
            if !self.item.dataIsFetched {
                withAnimation(self.graphAnimation) {
                    self.animatedAmount = rate
                }
            }
        }
        .onAppear {
            if self.item.dataIsFetched {
                withAnimation(self.graphAnimation) {
                    self.animatedAmount = self.item.rate
                }
            }
        }
    }
}

struct ModeItemView_Previews: PreviewProvider {
    static var previews: some View {
        ModeItemView(item: ModeItemData(content: Mode()))
    }
}
