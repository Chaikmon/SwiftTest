//
//  ViewController.swift
//  testTableNew
//
//  Created by chaikmon on 21/1/2563 BE.
//  Copyright © 2563 Advanced Research Group. All rights reserved.
//

import UIKit

// 1 create protocol
protocol ViewControllerDelegate {
    func saveData( account: Account? )
}

class ViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var buttonOk: UIButton!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDesc: UITextField!
    
    // MARK: - Properties

    var delegate: ViewControllerDelegate!
    var indexRow: Int?
    var account: Account!
    
    // MARK: - ViewControllerLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }

    // MARK: - Setup
    
    func setView() {
        
        textName.delegate = self
        textDesc.delegate = self
        textName.text = (account != nil) ? account.name : ""
        textDesc.text = (account != nil) ? account.desc : ""
        textName.attributedPlaceholder = NSAttributedString(string:"ชื่อ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textDesc.attributedPlaceholder = NSAttributedString(string:"ตำแหน่ง", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        if indexRow == nil {
            buttonOk.setTitle("บันทึก", for: UIControl.State.normal)
            navigationItem.title = "เพิ่มข้อมูลลูกค้า/ผู้จัดจำหน่าย"
        } else {
            buttonOk.setTitle("แก้ไข", for: UIControl.State.normal)
            navigationItem.title = "แก้ไขข้อมูลลูกค้า/ผู้จัดจำหน่าย"
        }
        
        mainView.cornerRadius(10)
        buttonOk.cornerRadius()
    }
    
    // MARK: - Actions
    
    @IBAction func onPress(_ sender: Any) {
        if shouldAccount(name: textName.text, desc: textDesc.text) {
            if account == nil {
                let accountAdd = Account.init(
                    name: textName.text!,
                    desc: textDesc.text!)
                delegate.saveData(account: accountAdd)
                
                print("Add")
            } else {
                account.name = textName.text!
                account.desc = textDesc.text!
                delegate.saveData(account: nil)
//                delegate.editData(account: accountEdit, row: indexRow!)
                
                print("Edit")
            }
            
            navigationController?.popViewController(animated: true)
            view.endEditing( true )
        } else {
            let alert = UIAlertController(title: nil, message: "กรุณากรอกข้อมูลให้ครบ", preferredStyle: UIAlertController.Style.alert)
            let button = UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.destructive, handler: nil)
            alert.addAction(button)
            present(alert, animated: true, completion: nil)
            return
        }
        
    }
    
    @IBAction func onPressView(_ sender: Any) {
        view.endEditing( true )
    }
    
    // MARK: - Validation
    
    func shouldAccount(name: String?, desc: String?) -> Bool {
        guard let name = name else {
            return false
        }
        guard let desc = desc else {
            return false
        }
        
        if name.count < 3 {
            return false
        }
        if desc.count < 3 {
            return false
        }
        
        return true
    }
    
    // MARK: - Utility
    
    
    
}

extension UIView {
    public func cornerRadius(_ value: CGFloat?=nil) {
        self.layer.cornerRadius = value == nil ? self.frame.height/2 : value!
        self.layer.masksToBounds = true
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textName {
            textDesc.becomeFirstResponder()
        } else if textField == textDesc {
            textDesc.resignFirstResponder()
            onPress( textField )
        }
        return true
    }
}

