//
//  ViewController.swift
//  SampleNotes
//
//  Created by 濱田一輝 on 2019/09/14.
//  Copyright © 2019 Kazuki Hamada. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var TextView: UITextView!
    
    let defaults = UserDefaults.standard
    
    var NoteList:[(title:String, text:String)] = []
    var TextList:[String] = []
    var row:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextView.text = NoteList[row].text
        
        for NoteData in NoteList {
            TextList.append(NoteData.text)
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        // TextViewが編集が開始されたらNavigationBarの右上にか「完了」ボタンを表示
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(endEditing))
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // TextViewの編集が終了したらNavigationBarの右上の「完了」ボタンを消す
        self.navigationItem.rightBarButtonItem = nil
        
        TextList[row] = TextView.text
        
        defaults.set(TextList, forKey: "NoteList")
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
}

