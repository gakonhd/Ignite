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
    var randomString : String?
    
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
            //convert all objects to a list of DatasnapShot
            let list:[DataSnapshot] = path.children.allObjects as! [DataSnapshot]
            //convert the list to dictionary type
            let myQuestionDictionary : NSDictionary? = list[rdn].value as? NSDictionary;
            guard let dict = myQuestionDictionary, let question = dict["text"] else {
                self.quoteOutlet.text = "Error getting questions. Please try again later"
                return
            }
            self.quoteOutlet.text = question as? String
            //self.randomString = self.quoteOutlet.text //class variable or scope varialbe
        }
    }
    //strong typed cast conversion

    func randomNumber(_ range : Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    // force unwraopping
    // if it is optional, then we transfer it, we need exclamation
    // nil will not throw error
    // swift lint
    //class Person {
    //  var name : String?
    //}
    // guard 
    //cocoapods.org
    //let p = Person()
}

