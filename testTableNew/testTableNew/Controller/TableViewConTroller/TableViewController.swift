//
//  TableViewController.swift
//  testTableNew
//
//  Created by chaikmon on 21/1/2563 BE.
//  Copyright © 2563 Advanced Research Group. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var accountList = [
        Account(name: "Ton", desc: "Mobile Technical Lead"),
        Account(name: "Big", desc: "iOS Developer"),
        Account(name: "Heart", desc: "iOS Developer"),
        Account(name: "Pote", desc: "iOS Developer"),
        Account(name: "Toon", desc: "iOS Developer")
    ]
    
    // MARK: - ViewControllerLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellView = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressFunc))
        longPress.minimumPressDuration = 1
        longPress.delaysTouchesBegan = true
        
        cellView.tag = indexPath.row
        cellView.addGestureRecognizer(longPress)
        
        let accountL = accountList [ indexPath.row ]
        let char = Array(accountL.name)
        cellView.labelName.text = accountL.name
        cellView.labelDesc.text = accountL.desc
        cellView.labelProfile.text = "\(char[0])"
        cellView.viewContent.layer.cornerRadius = 10
        cellView.viewProfile.layer.cornerRadius = cellView.viewProfile.frame.height/2
        
        tableView.backgroundColor = .lightGray
        tableView.rowHeight = cellView.frame.height
        
        return cellView
    }
    
    @objc func longPressFunc(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            let alert = UIAlertController(title: nil, message: "คุณต้องการลบข้อมูล", preferredStyle: UIAlertController.Style.alert)
            let buttonOk = UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.destructive) { (alert) in
                guard let indexRow = gesture.view?.tag else {
                    return
                }
                    
                self.accountList.remove(at: indexRow)
                self.tableView.reloadData()
                
                print("Delete")
            }
            let buttonCancel = UIAlertAction(title: "ยกเลิก", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(buttonCancel)
            alert.addAction(buttonOk)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = accountList [ indexPath.row ]
        
        performSegue(withIdentifier: "goPage2", sender: account)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goPage2"{
            if let segueVC = segue.destination as? ViewController {
                guard let account = sender as? Account else {
                    return
                }
                segueVC.delegate = self // connect protocol เชื่อม protocol จาก propleteis ที่ประกาศไว้ในหน้า create protocol
                segueVC.account = account
            }
        } else if segue.identifier == "addData" {
            if let segueVC = segue.destination as? ViewController {
                segueVC.delegate = self
            }
        }
    }
    
}
// 2 implement  protocol
extension TableViewController: ViewControllerDelegate {
    
    func saveData(account: Account?) {
        
//        if account != nil {
//            guard let accountData = account as? Account else {
//                return
//            }
//            accountList.append( accountData )
//            tableView.reloadData()
//        } else {
//            tableView.reloadData()
//        } ใช้วิธี opional binding จะสั้นและง่ายกว่า
        
        if let account = account { // opional binding
            accountList.append( account )
        }
        tableView.reloadData()
    }
    
}
