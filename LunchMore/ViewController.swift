//
//  ViewController.swift
//  LunchMore
//
//  Created by Alonzo Trove on 4/11/15.
//  Copyright (c) 2015 Alonzo Trove. All rights reserved.
//

import UIKit
import Parse

extension UIColor{
    class func randomColor(hue:CGFloat? = ( CGFloat( CGFloat(arc4random()) % 256 / 256.0 ) ),
        saturation:CGFloat? = ( CGFloat( CGFloat(arc4random()) % 128 / 256.0 ) + 0.5 ),
        brightness:CGFloat? = ( CGFloat( CGFloat(arc4random()) % 128 / 256.0 ) + 0.5 ),
        alpha:CGFloat? = CGFloat(1.0)) -> UIColor{
            return UIColor(hue: hue!, saturation: saturation!, brightness: brightness!, alpha: alpha!);
    }
}

class ViewController: UIViewController, UITableViewDelegate {
    
    var rowColors=[""]
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rowColors=["90AAFF", "FFC090", "90FF06", "9A5E22", "FECB98", "55C7D4", "0EF699", "B96626"]
        self.contacts = [Contact(name: "Alonzo"),Contact(name: "Chin"),Contact(name: "Jacob"),Contact(name: "Kendrick")]
    
        //Add background image to table view
        //self.tableView.backgroundView = UIImageView(image: UIImage(named: "LunchBackground"))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.rowHeight = 44.0
        return self.contacts.count
    }
        //Function to use HEX Codes to create colors of the rows
    func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor {
        var scanner = NSScanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let randomIndex = Int(arc4random_uniform(UInt32(rowColors.count)))                          //Select random HEX code
        var contact : Contact
        
        contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.name
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont(name: "Avenir", size: 44.0)
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        cell.contentView.backgroundColor = UIColorFromRGB(rowColors[randomIndex])                   //Random HEX code makes bakcground color
        cell.backgroundView = UIImageView(image: UIImage(named: "LunchBackground"))
        rowColors.removeAtIndex(randomIndex)
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.performSegueWithIdentifier("showDetails", sender: tableView)
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.textLabel!.text = "Sent!"
        let push = PFPush()
        push.setMessage("Lunch?")
        push.sendPushInBackground()
    }

}

