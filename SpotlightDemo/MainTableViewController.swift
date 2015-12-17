//
//  ViewController.swift
//  SpotlightDemo
//
//  Created by Broccoli on 15/12/17.
//  Copyright © 2015年 Broccoli. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class MainTableViewController: UITableViewController {
    lazy var tableViewData: [SpotlightModel] = {
        var arr = [SpotlightModel]()
        for _ in 0..<30 {
            arr.append(SpotlightModel.createRandomData())
        }
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var searchableItems = [CSSearchableItem]()
        
        for model in tableViewData {
            let attri = CSSearchableItemAttributeSet(itemContentType: kUTTypeMessage as String)
            attri.title = model.text
            attri.contentDescription = model.detailText
            attri.thumbnailData = UIImagePNGRepresentation(model.image)
            
            let searchableItem = CSSearchableItem(uniqueIdentifier: model.text, domainIdentifier: "com.broccoli", attributeSet: attri)
            searchableItems.append(searchableItem)
        }
        
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems(searchableItems, completionHandler: nil)
        
    }
}

// MARK: - table view data source
private let CellIdentifier = "MainTableViewCell"
extension MainTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = tableViewData[indexPath.row].text
        cell.detailTextLabel?.text = tableViewData[indexPath.row].detailText
        cell.imageView?.image = tableViewData[indexPath.row].image
        return cell
    }
}

class SpotlightModel {
    var image: UIImage!
    var text: String!
    var detailText: String!
    
    class func createRandomData() -> SpotlightModel {
        let model = SpotlightModel()
        model.image = UIImage(named: "image\(arc4random() % 3)")
        model.detailText = "detailText\(arc4random() % 100)"
        model.text = "text\(arc4random() % 300)"
        return model
    }
}