//
//  ChatViewController.swift
//  EasyChat
//
//  Created by Ty Pham on 23/02/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var onLogout: UIButton!
    
    let db = Firestore.firestore()
    var user: UserInfo!
    let roomId: String = "KKzQjzhNBHJzFAe74VvV"
    let collectionName = "message"
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rotate = CGAffineTransform(rotationAngle: .pi)
        tableView.transform = rotate
        
        getData()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(RightChatMessageCell.self, forCellReuseIdentifier: "RightChatMessageCell")
        tableView.register(LeftChatMessageCell.self, forCellReuseIdentifier: "LeftChatMessageCell")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapLogout(_ sender: Any) {
        try? Auth.auth().signOut()
        gotoLogin()
    }
    
    func getData() {
        db.collection(collectionName)
            .order(by: "createdAt", descending: true)
            .whereField("roomId", isEqualTo: roomId)
            .addSnapshotListener() { querySnapshot, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.messages = documents.compactMap { item in
                    var dict = item.data()
                    dict["ID"] = item.documentID
                    return dict
                }.compactMap {self.toMessage(dict: $0)}
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
    }
    
    func toMessage(dict: [String: Any]) -> Message? {
        let decoder = JSONDecoder()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dict) else {
            return nil
        }
        return try? decoder.decode(Message.self, from: jsonData)
    }

    func publishMessage(text: String) {
        db.collection(collectionName).document(UUID().uuidString).setData([
            "authorId": user.uid,
            "authorName": user.displayName ?? "Anonymous",
            "data": text,
            "roomId": roomId,
            "type": "text",
            "createdAt": Date().milliseconds
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                self.textField.text = ""
            }
        }
    }
   
    @IBAction func onSend(_ sender: Any) {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        
        publishMessage(text: text)
    }
    
    func gotoLogin() {
        self.dismiss(animated: true)
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.messages[indexPath.row]
        if item.authorId == user.uid {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightChatMessageCell", for: indexPath) as! RightChatMessageCell
            
            cell.setupUI(model: item)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftChatMessageCell", for: indexPath) as! LeftChatMessageCell
            
            cell.setupUI(model: item)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
}

struct Message: Codable {
    let ID: String
    let authorId: String
    let authorName: String
    let type: String
    let data: String
    let roomId: String
    let createdAt: Int64
}

extension Date {
    var milliseconds:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}
