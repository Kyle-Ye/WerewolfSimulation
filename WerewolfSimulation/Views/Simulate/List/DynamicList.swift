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
    }

//    init(data: Binding<[Item.Content]>) {
//        self.data = Binding<[Item.Content]>.init(get: {
//            data.wrappedValue
//        }, set: { newValue in
//            let diffs = newValue.difference(from: data.wrappedValue).inferringMoves()
//            for diff in diffs {
//                switch diff {
//                case let .remove(offset, oldElement, associated):
//                    if let associated = associated {
//                    } else {
//                        self.list.remove(at: offset)
//                    }
//                    break
//                case let .insert(offset, newElement, associated):
//                    if let associated = associated {
//                        self.list.move(fromOffsets: IndexSet(integer: associated), toOffset: offset)
//                    } else {
//                        self.list.insert(Item(content: newElement), at: offset)
//                    }
//                    break
//                }
//            }
//            data.wrappedValue = newValue
//        })
//        for content in data.wrappedValue {
//            list.append(Item(content: content))
//        }
//    }

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
}

protocol DynamicListRow: View {
    associatedtype Item: ListDataItem
    var item: Item { get }
    init(item: Item)
}

struct DynamicList<Row: DynamicListRow>: View where Row.Item: Hashable {
    @EnvironmentObject var listProvider: ListDataProvider<Row.Item>

    var body: some View {
        return
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
    }

    private func move(from source: IndexSet, to destination: Int) {
        listProvider.data.move(fromOffsets: source, toOffset: destination)
    }

    private func remove(at offsets: IndexSet) {
        listProvider.data.remove(atOffsets: offsets)
    }
}
