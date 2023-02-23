//
//  ViewController.swift
//  EasyChat
//
//  Created by Ty Pham on 23/02/2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        if let user = Auth.auth().currentUser {
            gotoChat(user: user)
        }
    }

    @IBAction func onTap(_ sender: Any) {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print(error)
                return
            }
            guard let user = authResult?.user else {
                return
                
            }
            let isAnonymous = user.isAnonymous  // true
            let uid = user.uid
            print(uid)
            print(user.displayName ?? "no name")
            self.gotoChat(user: user)
        }
    }
    
    func gotoChat(user: UserInfo) {
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.user = user
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

