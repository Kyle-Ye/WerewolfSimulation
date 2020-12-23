//
//  CheckListView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/23.
//

import SwiftUI

struct CheckListView: View {
    var body: some View {
        TabView {
            Text("Tab Content 1").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 1")/*@END_MENU_TOKEN@*/ }.tag(1)
            Text("Tab Content 2").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 2")/*@END_MENU_TOKEN@*/ }.tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListView()
    }
}
