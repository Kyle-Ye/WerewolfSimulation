//
//  RateSimulation.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/11/22.
//

import CoreMafia
import SwiftUI

struct RateSimulation: View {
    @StateObject var config = GameConfig()
    @StateObject var rule = GameRule()
    @State private var show = false
    @State private var compare = false
    @State private var check = false
    var body: some View {
        ScrollView {
            ModeEditor(config: config,rule: rule)
            NavigationLink(
                destination: ResultView(config: config),
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

            HStack {
                Button(action: {
                    
                }, label: {
                    Spacer()
                    Label(
                        title: { Text("Add mode") },
                        icon: { Image(systemName: "gauge.badge.plus") }
                    )
                    Spacer()
                })
                    .padding()
                    .foregroundColor(.primary)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()

                NavigationLink(
                    destination: CheckListView(),
                    isActive: $check,
                    label: {
                        Button(action: {
                            check.toggle()
                        }, label: {
                            Spacer()
                            Text("Check")
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
}

struct RateSimulation_Previews: PreviewProvider {
    static var previews: some View {
        RateSimulation()
            .accentColor(.orange)
//            .preferredColorScheme(.dark)
    }
}

struct LibraryProvider: LibraryContentProvider {
//    @LibraryContentBuilder
//    var views: [LibraryItem] {
//        LibraryItem(
//            Button("Start Simulation") {},
//            visible: true,
//            category: .effect,
//            matchingSignature: "kyleLink")
//    }
    @LibraryContentBuilder
    func modifiers(base: Button<Text>) -> [LibraryItem] {
        LibraryItem(
            base.padding()
                .foregroundColor(.primary)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 20)),
            title: "RoundedRectangle Button"
        )
    }
}
