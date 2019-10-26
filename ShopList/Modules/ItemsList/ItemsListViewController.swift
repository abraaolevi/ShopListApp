//
//  ItemsListViewController.swift
//  ShopList
//
//  Created by Abraao Levi on 18/02/19.
//  Copyright © 2019 Abraao Levi. All rights reserved.
//

import UIKit

class ItemsListViewController: UITableViewController {
    
    // MARK: Properties
    
    var viewModel: ItemsListViewModel?

    // MARK: LIfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        
        viewModel?.rowViewModels.addObserver { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    func initTableView() {
        tableView.register(UINib(nibName: ItemListCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: ItemListCell.cellIdentifier())
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel?.rowViewModels.value.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemListCell.cellIdentifier(), for: indexPath)

        if let cell = cell as? CellConfigurable {
            if let viewModel = viewModel?.getRowViewModel(at: indexPath) {
                cell.setup(viewModel: viewModel)
            }
        }

        return cell
    }

    @IBAction func addItemButtonClicked(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        
        var nameTextField = UITextField()
        alertController.addTextField {
            (textField) in
            nameTextField = textField
            nameTextField.placeholder = "Item name"
        }
        
        var priceTextField = UITextField()
        alertController.addTextField { (textField) in
            priceTextField = textField
            priceTextField.placeholder = "Price"
        }
  
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            if let name = nameTextField.text, let price = priceTextField.text {
                self.viewModel?.createItem(name: name, price: Decimal(string: price) ?? Decimal(0))
                self.tableView.reloadData()
            }
        }

        alertController.addAction(addAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
