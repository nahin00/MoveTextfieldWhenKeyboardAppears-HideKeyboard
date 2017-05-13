//
//  ViewController.swift
//  Move textfield when keyboard appears, Hide keyboard
//
//  Created by Nahin Ahmed on 5/13/17.
//  Copyright © 2017 Nahin Ahmed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
   
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameTextFieldBottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var postBtnBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.hideKeyboardWhenTappedAround()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWasShown), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func dismissKeyboard() {
        
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.nameTextFieldBottomConstraint.constant = 8
            self.postBtnBottomConstraint.constant = 8
        })
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }

 
    func keyboardWasShown(notification: NSNotification) {
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.nameTextFieldBottomConstraint.constant = keyboardFrame.size.height + 20
            self.postBtnBottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }
    
    
    
    @IBAction func postBtnTapped(_ sender: UIButton) {
        
        guard let name = nameTextField.text else {
            return
        }
        
        nameLbl.text = name
    }
    
    


}

//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}
