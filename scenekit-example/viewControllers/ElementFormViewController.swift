//
//  ElementFormViewController.swift
//  scenekit-example
//
//  Created by MacBook on 3/8/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

enum ElementFormCellType {
    case position(callback: UpdatePositionCallback)
}

class ElementFormViewController: UITableViewController {
    
    var items: [ElementFormCellType] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "PositionTableViewCell", bundle: nil), forCellReuseIdentifier: "positionCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "positionCell", for: indexPath) as! PositionTableViewCell
        switch items[indexPath.row] {
        case .position(callback: let callback):
            cell.setCallback(callback)
        }
        return cell
    }
}
