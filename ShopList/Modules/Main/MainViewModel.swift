//
//  MainViewModel.swift
//  ShopList
//
//  Created by Abraao Levi on 16/02/19.
//  Copyright © 2019 Abraao Levi. All rights reserved.
//

import Foundation

class MainViewModel {

    let repository: ListRepository

    let rowViewModels = Observable<[RowViewModel]>(value: [])
    
    private var _selectedList: List? = nil
    var selectedList: List? {
        set { _selectedList = newValue }
        get {
            return _selectedList
        }
    }

    init(repository: ListRepository = ListRepository()) {
        self.repository = repository
        reloadData()
    }
    
    func reloadData() {
        let lists = repository.findAllLists()
        buildRowViewModels(lists)
    }
    
    func buildRowViewModels(_ lists: [List]) {
        var rowVMs = [RowViewModel]()
        for list in lists {
            rowVMs.append(MainCellViewModel(list))
        }
        rowViewModels.value = rowVMs
    }

    func getRowViewModel(at indexPath: IndexPath) -> RowViewModel {
        return rowViewModels.value[indexPath.row]
    }

    func createList(name: String) -> Void {
        let list = List()
        list.name = name
        repository.add(list)
        reloadData()
    }

    func deleteList(at index: Int) -> Void {
        guard let rowVM = getRowViewModel(at: IndexPath(row: index, section: 0)) as? MainCellViewModel else {
            return
        }
        
        repository.delete(rowVM.list)
        reloadData()
    }
    
}
