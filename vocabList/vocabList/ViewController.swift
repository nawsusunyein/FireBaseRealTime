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
    var vocabList : [[String : String]] = [[String : String]]()
    var vocabModelList : [VocabModel] = [VocabModel]()
    
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
                
            }else{
                self.readVocabListData()
            }
            
        })
    }

    private func insertVocabListData(){
        let vocabData1 = ["cn": "狗" as String, "en" : "dog" as String]
        let vocabData2 = ["cn": "好" as String, "en" : "good" as String]
        let vocabData3 = ["cn" : "花" as String, "en": "flower" as String]
        let vocabData4 = ["cn": "玫瑰" as String, "en": "rose" as String]
        let vocabData5 = ["cn": "红" as String, "en": "red" as String]
        let vocabData6 = ["cn": "白" as String, "en": "white" as  String]
        
        vocabList.append(vocabData1)
        vocabList.append(vocabData2)
        vocabList.append(vocabData3)
        vocabList.append(vocabData4)
        vocabList.append(vocabData5)
        vocabList.append(vocabData6)
        
        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData1)
        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData2)
        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData3)
        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData4)
        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData5)
        databaseRefer.child("vocabs").childByAutoId().setValue(vocabData6)
        
        print("vocab list count : \(vocabList.count)")
        self.readVocabListData()
    }

    private func readVocabListData(){
        databaseRefer.child("vocabs").observeSingleEvent(of: .value, with: {snapshot in
            for child in (snapshot.children){
                print("child value : \(child)")
                let vocabDataSnapShot = child as! DataSnapshot
                let vocabDict = vocabDataSnapShot.value as! [String : Any]
                let cnValue = vocabDict["cn"] as! String
                let enValue = vocabDict["en"] as! String
                           
                let vocabData = VocabModel(cnValue: cnValue as NSString, enValue: enValue as NSString)
                self.vocabModelList.append(vocabData)
                           
            }
            
            print("vocab model list count : \(self.vocabModelList.count)")
        })
    }
}

