//
//  CheckListView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/23.
//

import SwiftUI

struct CheckListView: View {
    @EnvironmentObject var listProvider: ListDataProvider<ModeItemData>

    var body: some View {
        DynamicList<ModeItemView>()
    }
}

struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListView()
            .environmentObject(ListDataProvider<ModeItemData>())
    }
}
