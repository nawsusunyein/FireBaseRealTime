//
//  ViewController.swift
//  vocabList
//
//  Created by techfun on 2020/02/28.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    var databaseRefer : DatabaseReference!
    var databaseHandle : DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        databaseRefer = Database.database().reference()
        
//        let vocabData1 = ["cn" : "狗" as String,
//                          "en" : "dog" as String
//                        ]
//        let vocabData2 = ["cn" : "好" as String,
//                          "en" : "good"
//        ]
//        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData1)
//        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData2)
        
        databaseRefer.child("vocabs").observeSingleEvent(of: .value, with: {snapshot in
            if !snapshot.exists() {return}
            print("Snapshot : \(snapshot)")
            print("Snapshot value : \(snapshot.value)")
            print("Snapshot key : \(snapshot.key)")
            
            for child in (snapshot.children){
                print("child value : \(child)")
                let vocabDataSnapShot = child as! DataSnapshot
                let vocabDict = vocabDataSnapShot.value as! [String : Any]
                let cnValue = vocabDict["cn"] as! String
                let enValue = vocabDict["en"] as! String
                
                print("cn value : \(cnValue)")
                print("en value : \(enValue)")
                
            }
            
            
            
        })
    }


}

