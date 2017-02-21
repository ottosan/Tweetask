//
//  AddViewController.swift
//  Tweetask
//
//  Created by 音石朋恵 on 2017/02/20.
//  Copyright © 2017年 tomoe.otoishi. All rights reserved.
//

import UIKit
import RealmSwift
import RAMAnimatedTabBarController

class AddViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var noticeSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var task: Task!
    let taskArray = try! Realm().objects(Task.self).sorted(byProperty: "date", ascending: false)
    let realm = try! Realm()
    
    // 通知スイッチ
    @IBAction func onOffSwitch(_ sender: Any) {
        if(noticeSwitch.isOn){
            datePicker.isHidden = false
        }else{
            datePicker.isHidden = true
        }
    }
    // キャンセルボタン
    @IBAction func cancelButton(_ sender: Any) {
        //リストに画面移動
        let rAMAnimatedTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! RAMAnimatedTabBarController
        self.present(rAMAnimatedTabBarController, animated: false, completion: nil)
    }
    
    // 完了ボタン
    @IBAction func doneButton(_ sender: Any) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            self.task.memo = self.memoTextView.text
            if(noticeSwitch.isOn){
                self.task.date = self.datePicker.date as NSDate
            }else{
                self.task.date = nil
            }
            self.realm.add(self.task, update: true)
        }
        // リストに画面移動
        let rAMAnimatedTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! RAMAnimatedTabBarController
        self.present(rAMAnimatedTabBarController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // コメントのTextViewに枠をつける。
        memoTextView.layer.borderWidth = 0.5
        // 枠の色を設定する。
        memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        // 枠の角を丸くする。
        memoTextView.layer.cornerRadius = 8
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)

        if (task == nil){
            task = Task()
            task.date = NSDate()
            if taskArray.count != 0 {
                task.id = taskArray.max(ofProperty: "id")! + 1
            }
        }else{
            titleTextField.text = task.title
            memoTextView.text = task.memo
            if(task.date != nil){
                noticeSwitch.setOn(true, animated: true)
                datePicker.date = task.date as Date
            }
        }
        // 通知がオフならdatePickerを隠す
        if(!noticeSwitch.isOn){
            datePicker.isHidden = true;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
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
