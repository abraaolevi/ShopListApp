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
    
    func reloadData(lists: [List]? = nil) {
        if lists == nil {
            let lists = repository.findAllLists()
            buildRowViewModels(lists)
        } else {
            buildRowViewModels(lists ?? [])
        }
    }
            
    func buildRowViewModels(_ lists: [List]) {
        rowViewModels.value = lists.map {
            MainCellViewModel($0)
        }
    }
    
    func filter(with name: String) {
        let namePredicate = NSPredicate(format: "name CONTAINS[c] %@", name)
        let filteredList = repository.filterAllLists(withPredicate: namePredicate)
        reloadData(lists: filteredList)
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
