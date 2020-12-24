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
        }
    }
}

// struct SingleSimulation_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleSimulation(mode: Mode())
//            .accentColor(.orange)
//    }
// }
