//
//  ElementsTableViewController.swift
//  scenekit-example
//
//  Created by MacBook on 3/8/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

enum TableViewCellType {
    case camera(_ callback: UpdatePositionCallback)
    case light(_ callback: UpdatePositionCallback)
    case item
}

typealias UpdatePositionCallback = (_ x: Float, _ y: Float, _ z: Float) -> Void

class ElementsTableViewController: UITableViewController {
    
    struct Constants {
        static let formSegueIdentifier = "showElementForm"
    }
    
    var items: [TableViewCellType] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func addNewElement(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.formSegueIdentifier, sender: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

        switch items[indexPath.row] {
        case .camera:
            cell.textLabel?.text = "CAMERA"
        case .light:
            cell.textLabel?.text = "LIGHT"
        default:
            print("")
        }
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.formSegueIdentifier, sender: items[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.formSegueIdentifier,
            let controller = segue.destination as? ElementFormViewController {
            if let type = sender as? TableViewCellType {
                switch type {
                case .camera(let callback):
                    controller.title = "CAMERA"
                    controller.items = [.position(callback: callback)]
                case .light(let callback):
                    controller.title = "LIGHT"
                    controller.items = [.position(callback: callback)]
                default:
                    print("")
                }
            }
            
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
