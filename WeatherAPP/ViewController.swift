//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Noor Rassam on 2020-12-10.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var rowSelected : Int?
    
    var tableList : [WeatherJSON] = []
    
    var country: Country? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if (segue.identifier == "DCell") {
                    if let svc = segue.destination as? DetailsViewController{
                        svc.country = country
                    }
                }
            }
    
    override func viewWillAppear(_ animated: Bool) {
        
        do{
            // when the view is about to display then trigger the fetch reequest
            try fetchResuts.performFetch()
        }catch let err as NSError{
            print("error is \(err.localizedDescription)")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // suppy the number of sections
        return fetchResuts.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return tableList.count
        // get sections from fetch request
        guard let sections = fetchResuts.sections else {
            return 0
        }
        
        // get the curernt active section instance
        let sectionInfo = sections[section]

        // return the total number of objects in a section
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // get the country object from the fetchresult
        let country = fetchResuts.object(at: indexPath)
        cell.textLabel?.text = country.city
        cell.detailTextLabel?.text = country.country_val
        return cell
    }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        country = fetchResuts.object(at: indexPath)
//        rowSelected = indexPath.row
        performSegue(withIdentifier: "DCell", sender: self)
    }
    
    lazy var fetchResuts: NSFetchedResultsController<Country> = {
        let fetchReq = NSFetchRequest<Country>(entityName: "Country")
        let description = NSSortDescriptor(key: "city", ascending: true)
        fetchReq.sortDescriptors = [description]
        
        let delegate =  UIApplication.shared.delegate as? AppDelegate
        let fetchController = NSFetchedResultsController(fetchRequest: fetchReq, managedObjectContext: (delegate?.persistentContainer.viewContext)!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchController
    }()

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
