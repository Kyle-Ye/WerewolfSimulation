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
                Text("Round: \(item.process)/\(item.content.round)")
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

struct GraphBar: View {
    let amount: Double?
    @Binding var animatedAmount: Double?
    init(amount: Double?, animatedAmount: Binding<Double?>, minus: Bool = false) {
        self.amount = amount
        if minus {
            _animatedAmount = Binding<Double?>.init(get: { () -> Double? in
                if let value = animatedAmount.wrappedValue {
                    return 1 - value
                }
                return nil
            }, set: { value in
                if let value = value {
                    animatedAmount.wrappedValue = 1 - value
                }
                animatedAmount.wrappedValue = nil
            })
        } else {
            _animatedAmount = animatedAmount
        }
    }

    var color: Color {
        guard let theAmount = amount else { return Color.gray }
        switch theAmount {
        case 0.0 ..< 0.3: return Color.red
        case 0.3 ..< 0.7: return Color.yellow
        case 0.7 ... 1.0: return Color.green
        default: return Color.gray
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Capsule()
                    .frame(maxWidth: CGFloat(geometry.size.width * CGFloat(self.animatedAmount ?? 0)), maxHeight: 20)
                    .foregroundColor(self.color)
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
        }
    }
}

struct ModeItemView_Previews: PreviewProvider {
    static var previews: some View {
        ModeItemView(item: ModeItemData(content: Mode()))
    }
}
