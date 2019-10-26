//
//  ItemsListViewModel.swift
//  ShopList
//
//  Created by Abraao Levi on 20/04/19.
//  Copyright © 2019 Abraao Levi. All rights reserved.
//

import Foundation


class ItemsListViewModel {
    
    let list: List
    let repository: ItemRepository
    
    let rowViewModels = Observable<[RowViewModel]>(value: [])
    
    init(list: List, repository: ItemRepository = ItemRepository()) {
        self.list = list
        self.repository = repository
        reloadData()
    }
    
    func reloadData() {
        let items = list.items.toArray(type: Item.self)
        buildRowViewModels(items)
    }
        
    func buildRowViewModels(_ items: [Item]) {
        var rowVMs = [RowViewModel]()
        for item in items {
            rowVMs.append(ItemListCellViewModel(item))
        }
        rowViewModels.value = rowVMs
    }
    
    func getRowViewModel(at indexPath: IndexPath) -> RowViewModel {
        return rowViewModels.value[indexPath.row]
    }
    
    func createItem(name: String, price: Decimal, discountType: Item.DicountType = .none, discountValue: Decimal? = nil) -> Void {
        let item = Item()
        item.name = name
        item.setPrice(price)
        item.setDiscount(type: discountType)
        item.setDiscount(value: discountValue)
        repository.add(item: item , list: list)
        reloadData()
    }
    
    func deleteItem(at index: Int) -> Void {
        guard let rowVM = getRowViewModel(at: IndexPath(row: index, section: 0)) as? ItemListCellViewModel else {
            return
        }
        
        repository.delete(rowVM.item)
        reloadData()
    }
}
