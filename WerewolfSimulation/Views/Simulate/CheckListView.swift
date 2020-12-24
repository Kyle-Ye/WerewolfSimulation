//
//  CheckListView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/23.
//

import SwiftUI

struct CheckListView: View {
    @State var modes: [Mode]
    var body: some View {
        List {
            ForEach(modes, id: \.self) { mode in
                ModeItemView(mode: mode)
            }
            .onMove(perform: move)
            .onDelete(perform: remove)
        }
        .navigationBarItems(trailing: EditButton())
    }
    private func move(from source: IndexSet, to destination: Int) {
        modes.move(fromOffsets: source, toOffset: destination)
    }
    private func remove(at offsets:IndexSet){
        modes.remove(atOffsets: offsets)
    }
}

struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListView(modes: [])
    }
}
