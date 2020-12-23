//
//  Stepper.swift
//  WerewolfSimulation-watch WatchKit Extension
//
//  Created by 叶絮雷 on 2020/11/22.
//

import SwiftUI

struct Stepper<Content>: View where Content: View {
    @Binding var value: Int
    var range: ClosedRange<Int>
    var step: Int = 1
    var label: Content
    init(value: Binding<Int>, in range: ClosedRange<Int>, step: Int = 1, @ViewBuilder content: () -> Content) {
        _value = value
        self.range = range
        self.step = step
        label = content()
    }

    var body: some View {
        HStack {
            label
                .frame(width:100)
            Spacer()
            Button {
                if value+step > range.upperBound{
                    value = range.upperBound
                }else{
                    value += step
                }
            } label: {
                Image(systemName: "plus")
            }
            Button {
                if value-step < range.lowerBound{
                    value = range.lowerBound
                }else{
                    value -= step
                }
            } label: {
                Image(systemName: "minus")
            }
        }
    }
}

struct Stepper_Previews: PreviewProvider {
    static var v = 15
    static var previews: some View {
        let value: Binding<Int> = Binding<Int>.init { () -> Int in
            v
        } set: { newValue in
            v = newValue
        }

        return
            ScrollView {
                Stepper(value: value, in: 1 ... 20) {
                    Text("N = \(v)")
                }
                Stepper(value: value, in: 1 ... 20) {
                    Text("N\nN\nM\na = \(v)")
                }
                Stepper(value: value, in: 1 ... 20) {
                    Text("round = \(v)")
                }
            }
    }
}
