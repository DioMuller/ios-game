//
//  HighScoreViewController.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 11/3/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import UIKit

class HighScoreViewController : UITableViewController {
    
    let tableItems : [HighscoreInfo] = HighScores().list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioManager.playMusic("Credits")
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer.enabled = false
    }
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    override func viewWillAppear(animated : Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("HighscoreCell") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "HighscoreCell")
        }
        
        cell?.textLabel.text = tableItems[indexPath.row].game
        cell?.detailTextLabel!.text = String(tableItems[indexPath.row].score)
        
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let index = tableView.indexPathForSelectedRow()
        let gameController = (segue.destinationViewController as GameViewController)
        gameController.index = index!.row
    }
    
}