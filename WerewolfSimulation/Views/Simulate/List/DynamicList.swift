//
//  DynamicList.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/24.
//

import SwiftUI

protocol ListDataItem {
    /// Fetch additional data of the item, possibly asynchronously
    associatedtype Content: Hashable
    init(content: Content)
    var content: Content { get set }

    func fetchData()

    /// Has the data been fetched?
    var dataIsFetched: Bool { get }
}

class ListDataProvider<Item: ListDataItem>: ObservableObject {
    init(data: [Item.Content] = []) {
        _data = Published(initialValue: data)
        for content in data {
            list.append(Item(content: content))
        }
    }

    @Published var data: [Item.Content] {
        willSet {
            let diffs = newValue.difference(from: data).inferringMoves()
            for diff in diffs {
                switch diff {
                case let .remove(offset, _, associated):
                    if associated == nil {
                        list.remove(at: offset)
                    }
                    break
                case let .insert(offset, newElement, associated):
                    if let associated = associated {
                        list.move(fromOffsets: IndexSet(integer: associated), toOffset: offset)
                    } else {
                        list.insert(Item(content: newElement), at: offset)
                    }
                    break
                }
            }
        }
    }

    private(set) var listID: UUID = UUID()

    @Published var list: [Item] = []

    func reset() {
        list = []
        listID = UUID()
        for content in data {
            list.append(Item(content: content))
        }
    }
}

protocol DynamicListRow: View {
    associatedtype Item: ListDataItem
    var item: Item { get }
    init(item: Item)
}

struct DynamicList<Row: DynamicListRow>: View where Row.Item: Hashable {
    @EnvironmentObject var listProvider: ListDataProvider<Row.Item>

    var body: some View {
        List {
            ForEach(listProvider.list, id: \.self) { item in
                Row(item: item)
                    .onAppear {
                        if !item.dataIsFetched {
                            item.fetchData()
                        }
                    }
            }
            .onMove(perform: move)
            .onDelete(perform: remove)
        }
        .id(self.listProvider.listID)
        .navigationBarItems(trailing:
            HStack(spacing: 20) {
                Button(action: {
                    listProvider.reset()
                }, label: {
                    Image(systemName: "arrow.clockwise.circle")
                })
                EditButton()
            }
        )
    }

    private func move(from source: IndexSet, to destination: Int) {
        listProvider.data.move(fromOffsets: source, toOffset: destination)
    }

    private func remove(at offsets: IndexSet) {
        listProvider.data.remove(atOffsets: offsets)
    }
}
