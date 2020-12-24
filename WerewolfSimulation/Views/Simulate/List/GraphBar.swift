//
//  GraphBar.swift
//  WerewolfSimulation
//  Source in https://github.com/callistaenterprise/SwiftUIListExample
//

import SwiftUI

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

struct GraphBar_Previews: PreviewProvider {
    static var previews: some View {
        GraphBar(amount: 0.3, animatedAmount: .constant(0.3))
    }
}
