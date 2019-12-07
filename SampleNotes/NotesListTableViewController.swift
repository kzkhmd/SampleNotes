//
//  NotesListTableViewController.swift
//  SampleNotes
//
//  Created by 濱田一輝 on 2019/09/14.
//  Copyright © 2019 Kazuki Hamada. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    var NoteList:[(title:String, text:String)] = []
    var TextList:[String] = []
    
    @IBAction func addNewNote(_ sender: UIBarButtonItem) {
        var NoteData:(title:String, text:String)
        
        NoteData.title = "新規メモ"
        NoteData.text = ""
        NoteList.append(NoteData)
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 50
        
        for NoteData in NoteList {
            TextList.append(NoteData.text)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let LoadedNoteList = defaults.stringArray(forKey: "NoteList")
        var NoteData:(title:String, text:String)
        var num = 1
        
        // メモ一覧は毎回UserDefaultsから読み込むので、NoteListはここで必ず初期化する
        NoteList = []
        
        if LoadedNoteList != nil {
            for text in LoadedNoteList! {
                NoteData.title = String(num)
                NoteData.text = text
                
                NoteList.append(NoteData)
                num += 1
            }
        }else{
            print("LoadedNoteList is nil!")
        }
        
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source
    
    // セクション数を返す
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // セクションごとの行数を返す
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteList.count
    }

    // 各行に表示するセルを返す
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let NoteData = NoteList[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = NoteData.title

        return cell
    }
    
    // セルをスワイプしたときの処理
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            NoteList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            var NoteText:[String] = []
            
            for NoteData in NoteList {
                NoteText.append(NoteData.text)
            }
            
            defaults.set(NoteText, forKey: "NoteList")
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNotes" {
            let NextView = segue.destination as! ViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                NextView.NoteList = NoteList
                NextView.row = (indexPath as NSIndexPath).row
            }
        }
    }
    
}
