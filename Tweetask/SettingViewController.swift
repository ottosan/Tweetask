//
//  SettingViewController.swift
//  Tweetask
//
//  Created by 音石朋恵 on 2017/02/23.
//  Copyright © 2017年 tomoe.otoishi. All rights reserved.
//

import UIKit
import TwitterKit

class SettingViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginOutButton: UIButton!
    
    // Twitterアカウント管理
    @IBAction func loginOutButton(_ sender: Any) {
        Twitter.sharedInstance().logIn { session, error in
            if (session != nil) {
                // ログアウト処理
                let store = Twitter.sharedInstance().sessionStore
                
                if let userID = store.session?.userID {
                    store.logOutUserID(userID)
                }
            }
            // ログイン画面に移動
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Twitter.sharedInstance().logIn { session, error in
            if (session != nil) {
                let username: String = (session?.userName)!
                self.nameLabel.text = username
            } else {
                self.nameLabel.text = "未設定"
                self.loginOutButton.setTitle("ログイン", for: .normal)
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
