//
//  RateSimulation.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/11/22.
//

import SwiftUI
import CoreMafia

struct RateSimulation: View {
    @StateObject var config = GameConfig()
    @State private var show = false
    var body: some View {
        ScrollView {
            ConfigureView(config: config)
            NavigationLink(
                destination: ResultView(config: config),
                isActive: $show,
                label: {
                    Button("Start Simulation") {
                        show.toggle()
                    }
                })
                .padding()
        }
    }
}

struct RateSimulation_Previews: PreviewProvider {
    static var previews: some View {
        RateSimulation()
    }
}
