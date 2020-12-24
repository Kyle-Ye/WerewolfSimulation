//
//  CheckListView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/23.
//

import SwiftUI

struct CheckListView: View {
    @State var modes: [Mode]
    var listProvider: ListDataProvider<ModeItemData>

    init(modes: [Mode]) {
        _modes = State<[Mode]>(initialValue: modes)
        listProvider = ListDataProvider<ModeItemData>(data: modes, itemBatchCount: 20, prefetchMargin: 3)
    }

    var body: some View {
        DynamicList<ModeItemView>(listProvider: listProvider)
        .navigationBarItems(trailing: EditButton())
    }
}

struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListView(modes: [])
    }
}
