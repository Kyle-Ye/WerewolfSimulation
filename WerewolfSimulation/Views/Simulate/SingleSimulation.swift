//
//  SingleSimulation.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/24.
//

import SwiftUI

struct SingleSimulation: View {
    @ObservedObject var mode: Mode = Mode()
    @State private var show = false
    @State private var compare = false
    @Binding var modes: [Mode]
    @Binding var add: Bool
    @Binding var disabled: Bool

    init(modes: Binding<[Mode]>, add: Binding<Bool>, disabled: Binding<Bool>) {
        _modes = modes
        _add = add
        _disabled = disabled
    }

    var body: some View {
        VStack {
            ModeEditor(mode: mode)
            NavigationLink(
                destination: ResultView(mode: mode),
                isActive: $show,
                label: {
                    Button(action: {
                        show.toggle()
                    }, label: {
                        Spacer()
                        Text("Start Simulation")
                        Spacer()
                    })
                        .padding()
                        .foregroundColor(.primary)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                })
                .padding()
            NavigationLink(
                destination: Text("Unimplemented"),
                isActive: $compare,
                label: {
                    Button(action: {
                        compare.toggle()
                    }, label: {
                        Spacer()
                        Text("Compare 2 Modes")
                        Spacer()
                    })
                        .padding()
                        .foregroundColor(.primary)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                })
                .padding()
                .onDisappear{
                    disabled = false
                }
        }
        .onChange(of: add, perform: { value in
            if add {
                modes.append(mode)
                add = false
            }
        })
    }
}

// struct SingleSimulation_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleSimulation(mode: Mode())
//            .accentColor(.orange)
//    }
// }
