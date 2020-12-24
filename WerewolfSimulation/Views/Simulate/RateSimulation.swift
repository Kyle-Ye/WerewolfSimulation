//
//  RateSimulation.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/11/22.
//

import CoreMafia
import SwiftUI

struct RateSimulation: View {
    @State private var modes = [Mode]()
    @State private var check = false
    @State private var compare = false
    @State private var add = false
    @State private var disabled = false
    var body: some View {
        ScrollView {
            SingleSimulation(modes: $modes, add: $add, disabled: $disabled)
            NavigationLink(
                destination: CompareView(),
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
                .onDisappear {
                    disabled = false
                }
            HStack {
                Button(action: {
                    add = true
                    disabled = true
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
                    .disabled(disabled)

                NavigationLink(
                    destination: CheckListView(modes: modes),
                    isActive: $check,
                    label: {
                        Button(action: {
                            check.toggle()
                        }, label: {
                            Spacer()
                            Text("Check" + (modes.isEmpty ? "" : " \(modes.count) modes"))
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
