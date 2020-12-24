//
//  DynamicList.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/12/24.
//

import SwiftUI

protocol ListDataItem {
    /// Fetch additional data of the item, possibly asynchronously
    associatedtype Content
    init(content: Content)
    var content: Content { get set }

    func fetchData()

    /// Has the data been fetched?
    var dataIsFetched: Bool { get }
}

class ListDataProvider<Item: ListDataItem>: ObservableObject {
    /// - Parameters:
    ///   - itemBatchCount: Number of items to fetch in each batch. It is recommended to be greater than number of rows displayed.
    ///   - prefetchMargin: How far in advance should the next batch be fetched? Greater number means more eager.
    ///                     Sholuld be less than temBatchSize.
    init(data: [Item.Content], itemBatchCount: Int = 20, prefetchMargin: Int = 3) {
        self.data = data
        itemBatchSize = itemBatchCount
        self.prefetchMargin = prefetchMargin
        reset()
    }

    private let data: [Item.Content]
    private let itemBatchSize: Int
    private let prefetchMargin: Int

    private(set) var listID: UUID = UUID()

    func reset() {
        list = []
        listID = UUID()
        fetchMoreItemsIfNeeded(currentIndex: -1)
    }

    @Published var list: [Item] = []

    /// Extend the list if we are close to the end, based on the specified index
    func fetchMoreItemsIfNeeded(currentIndex: Int) {
        guard currentIndex >= list.count - prefetchMargin else { return }
        let startIndex = list.count
        for currentIndex in startIndex ..< max(startIndex + itemBatchSize, currentIndex) {
            if data.count > currentIndex {
                let content = data[currentIndex]
                list.append(Item(content: content))
                list[currentIndex].fetchData()
            }
        }
    }
}

protocol DynamicListRow: View {
    associatedtype Item: ListDataItem
    var item: Item { get }
    init(item: Item)
}

struct DynamicList<Row: DynamicListRow>: View {
    @ObservedObject var listProvider: ListDataProvider<Row.Item>
    var body: some View {
        return
            List {
                ForEach(0 ..< listProvider.list.count, id: \.self) { index in
                    Row(item: self.listProvider.list[index])
                        .onAppear {
                            self.listProvider.fetchMoreItemsIfNeeded(currentIndex: index)
                        }
                }
                .onMove(perform: move)
                .onDelete(perform: remove)
            }
            .id(self.listProvider.listID)
    }

    private func move(from source: IndexSet, to destination: Int) {
        listProvider.list.move(fromOffsets: source, toOffset: destination)
    }

    private func remove(at offsets: IndexSet) {
        listProvider.list.remove(atOffsets: offsets)
    }
}
