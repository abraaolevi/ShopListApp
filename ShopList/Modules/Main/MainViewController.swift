//
//  MainViewController.swift
//  ShopList
//
//  Created by Abraao Levi on 16/02/19.
//  Copyright © 2019 Abraao Levi. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: Properties
    let viewModel = MainViewModel()
    
    // MARK: Life cicly
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        
        viewModel.rowViewModels.addObserver { [weak self] _ in
            self?.tableView.reloadData()
        }

        searchBar.delegate = self
    }

    func initTableView() {
        // register tableview's cell
        tableView.register(UINib(nibName: MainCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: MainCell.cellIdentifier())
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowViewModels.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.cellIdentifier(), for: indexPath)

        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: viewModel.getRowViewModel(at: indexPath))
        }
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            viewModel.deleteList(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "itemsListSegue", sender: viewModel.getRowViewModel(at: indexPath))
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "itemsListSegue" {
            if let destination = segue.destination as? ItemsListViewController {
                guard let selected = sender as? MainCellViewModel else { return }
                destination.viewModel = ItemsListViewModel(list: selected.list)
            }
        }
    }
 
    // MARK: - Action handlers
    
    @IBAction func onTapAddButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add new List", message: nil, preferredStyle: .alert)
        
        var alertTextField = UITextField()
        alertController.addTextField {
            (textField) in
            alertTextField = textField
            alertTextField.placeholder = "List name"
        }

        let addAction = UIAlertAction(title: "Add", style: .default) {
            (action) in
            if let listName = alertTextField.text {

                self.viewModel.createList(name: listName)

                self.tableView.reloadData()
            }
        }
        alertController.addAction(addAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchedText = searchBar.text {
            debugPrint(searchedText)
            viewModel.filter(with: searchedText)
            if searchedText.count == 0 {
                viewModel.reloadData()
            }
        }
    }
}
