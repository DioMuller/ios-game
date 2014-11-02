//
//  LevelSelectionViewController.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 11/2/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import UIKit

class SelectionViewController : UITableViewController {
    
    let tableItems : [MinigameInfo] = Minigames.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioManager.playMusic("Credits")
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer.enabled = false
    }
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MinigameCell") as? UITableViewCell
        
        cell?.textLabel.text = tableItems[indexPath.row].title
        
        var imageName = UIImage(named: tableItems[indexPath.row].hero.image)
        cell?.imageView.image = imageName
        
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let index = tableView.indexPathForSelectedRow()
        let gameController = (segue.destinationViewController as GameViewController)
        gameController.index = index!.row
    }

}