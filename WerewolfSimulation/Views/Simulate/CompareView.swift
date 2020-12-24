//
//  CompareView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/24.
//

import SwiftUI

struct CompareView: View {
    @ObservedObject var mode1 = Mode()
    @ObservedObject var mode2 = Mode()
    @State var start = false
    var body: some View {
        ScrollView {
            ModeEditor(mode: mode1)
            Divider()
            ModeEditor(mode: mode2)
            Divider()
            NavigationLink(
                destination: CheckListView(modes: [mode1, mode2]),
                isActive: $start,
                label: {
                    Button(action: {
                        start.toggle()
                    }, label: {
                        Spacer()
                        Text("Start Compare")
                        Spacer()
                    })
                        .padding()
                        .foregroundColor(.primary)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                })
        }
    }
}

struct CompareView_Previews: PreviewProvider {
    static var previews: some View {
        CompareView()
    }
}
