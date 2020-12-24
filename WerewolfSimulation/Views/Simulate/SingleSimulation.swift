//
//  SingleSimulation.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/24.
//

import SwiftUI

struct SingleSimulation: View {
    @ObservedObject var mode: Mode
    @State private var show = false
    @Binding private var disabled: Bool
    private var modes:[Mode]
    init(modes:[Mode],mode: Mode, disabled: Binding<Bool>) {
        self.modes = modes
        _mode = ObservedObject<Mode>.init(initialValue: mode)
        _disabled = disabled
    }

    var body: some View {
        VStack {
            ModeEditor(mode: mode)
                .onAppear{
                    print("ModeEditor in")
                }
                .onDisappear{
                    print("ModeEditor out")
                }
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
                .onAppear{
                    print("NavigationLink in")
                }
                .onDisappear{
                    print("NavigationLink out")
                }
        }
        .onAppear{
            print("SingleSimulation in")
            disabled = modes.contains(mode)
        }
        .onDisappear{
            print("SingleSimulation out")
        }
        .onChange(of: mode) { (mode) in
            print("Change")
        }
    }
}

// struct SingleSimulation_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleSimulation(mode: Mode())
//            .accentColor(.orange)
//    }
// }
