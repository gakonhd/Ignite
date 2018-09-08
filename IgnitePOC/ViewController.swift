//
//  ViewController.swift
//  IgnitePOC
//
//  Created by Dang Ton on 8/9/18.
//  Copyright © 2018 Dang Ton. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var ref : DatabaseReference!
    var quote : String!
    var count : Int!
    
    
    @IBOutlet weak var quoteOutlet : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GetNewQuestion(){
        _ =  ref.observe(.value){ snapshot in
            let path = snapshot.childSnapshot(forPath: "question")
            let childCount = path.childrenCount
            let rdn = self.randomNumber(1..<Int(childCount))
            let list = path.children.allObjects
            let question = ((list[rdn] as! DataSnapshot).value as? NSDictionary)!["text"] as! NSString
            self.quoteOutlet.text = question as String? 
        }
    }

    func randomNumber(_ range : Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }

}

