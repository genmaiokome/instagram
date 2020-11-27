//
//  commentViewController.swift
//  Instagram
//
//  Created by 渡辺涼介 on 2020/11/27.
//  Copyright © 2020 ryosuke.watanabe. All rights reserved.
//

import UIKit
import Firebase

class commentViewController: UIViewController {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentLabel: UILabel!
    
    var postArray: [PostData] = []
    var indexPathRow = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        commentTextView.becomeFirstResponder()
        let toName = postArray[indexPathRow].name
        commentLabel.text = "\(toName!)さんの投稿へのコメントを入力"
        
    }
    
    
    @IBAction func sendButton(_ sender: Any) {
        
        let name = Auth.auth().currentUser?.displayName
        let postComment = "\(name!): \(commentTextView.text ?? "")\n"
        let postData = postArray[indexPathRow]
        let AllComment: String
        
        if postData.comments != nil {
             AllComment = postData.comments! + postComment
        } else {
             AllComment = "コメント\n" + postComment
        }
        
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        postRef.updateData(["comments": AllComment])
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
