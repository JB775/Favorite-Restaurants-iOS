//
//  TableViewController.swift
//  Favorite Restaurants
//
//  Created by jbergandino on 3/23/16.
//  Copyright © 2016 gotrackingtechnologies. All rights reserved.
//

import UIKit

//Define a dictionary to save new restaurants added
var places = [Dictionary<String, String>()]
//Instantiate an active place variable to be used to tell which restaurant user tapped
var activePlace = -1

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Places dictionary will show a count of 1 after being created so need to check for >1, if empty remove initial entry and add Taj Mahal
        if places.count == 1 {
        
            //Remove
            places.removeAtIndex(0)
            //Add Taj Mahal if empty
            places.append(["name":"Taj Mahal", "lat":"27.175277" ,"lon":"78.042128" ])
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = places[indexPath.row]["name"]
        
        return cell
    }

    
    //This function sends the row data from this view to the next by setting a value to a global variable
    // Variable is defined outside the otherclass and therefore available to be set in this class
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    
        //to link what was tapped and what is shown
        activePlace = indexPath.row
        return indexPath
    }
    
    //Update table whenever it is shown to make sure everything is current data
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    
    //Set navbar plus button to always stay on users current location (or else it will stay on most recent added location)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newPlace" {
        
            //if you don't set this back to -1 it will change location to most recent added location
            activePlace = -1
        }
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
