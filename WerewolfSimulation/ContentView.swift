//
//  ContentView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/10/4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                RateSimulation()
                    .tabItem {
                        Label("Rate Simulation", systemImage: "gamecontroller")
                    }
                SingleGame()
                    .tabItem {
                        Label("Single Game", systemImage: "ladybug")
                    }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
