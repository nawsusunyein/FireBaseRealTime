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
    var vocabList : [VocabModel] = [VocabModel]()
    
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
            if !snapshot.exists() {
                print("not exists")
                self.insertVocabListData()
                return
                
            }
            print("Snapshot : \(snapshot)")
            print("Snapshot value : \(snapshot.value)")
            print("Snapshot key : \(snapshot.key)")
            
            for child in (snapshot.children){
                print("child value : \(child)")
                let vocabDataSnapShot = child as! DataSnapshot
                let vocabDict = vocabDataSnapShot.value as! [String : Any]
                let cnValue = vocabDict["cn"] as! String
                let enValue = vocabDict["en"] as! String
                
                let vocabData = VocabModel(cnValue: cnValue as NSString, enValue: enValue as NSString)
                self.vocabList.append(vocabData)
                
                print("cn value : \(cnValue)")
                print("en value : \(enValue)")
                
            }
            
            
            
        })
    }

    private func insertVocabListData(){
        let vocabData1 = VocabModel(cnValue: "狗", enValue: "dog")
        let vocabData2 = VocabModel(cnValue: "好", enValue: "good")
        let vocabData3 = VocabModel(cnValue: "花", enValue: "flower")
        let vocabData4 = VocabModel(cnValue: "玫瑰", enValue: "rose")
        let vocabData5 = VocabModel(cnValue: "红", enValue: "red")
        let vocabData6 = VocabModel(cnValue: "白", enValue: "white")
        
        vocabList.append(vocabData1)
        vocabList.append(vocabData2)
        vocabList.append(vocabData3)
        vocabList.append(vocabData4)
        vocabList.append(vocabData5)
        vocabList.append(vocabData6)
        
        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData1 as Any)
        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData2)
        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData3)
        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData4)
        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData5)
        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData6)
        
        print("vocab list count : \(vocabList.count)")
    }

}

