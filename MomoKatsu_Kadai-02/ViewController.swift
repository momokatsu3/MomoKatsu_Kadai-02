//
//  ViewController.swift
//  MomoKatsu_Kadai-02
//
//  Created bby モモカツ on 2023/04/06.
//

import UIKit

class ViewController: UIViewController {
    
    // テキストフィールドを設定
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!

    // 計算結果表示用のラベルを設定
    @IBOutlet weak var calculationResultLabel: UILabel!
    
    // SegmentedControlで選択された演算子を選定するフラゲ
    // ＋：１　ー：２　×：３　÷：４
    var calculateFlg: Int = 1   // 何も選択しない場合、デフォルトとして ＋：１を初期設定
    // SegmentedControlで選択された演算子を設定
    var calculateArithmetic: String = "＋"   // 何も選択しない場合、デフォルトとして"＋"を初期設定
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // テキストフィールドを初期化
        textField1.text = ""
        textField2.text = ""
        
        //↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
        //  【Swift】キーボードと一緒にViewも上げる方法
        //  https://orangelog.site/swift/slide-view-with-keyboard/
        self.textField1.delegate = self
        self.textField2.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        //↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
        
        // 各textFieldでクリックした際にキーボードタイプを数字のみに変更する
        // numberPad や decimalPad を使用すると、Can't find keyplane that supports type 4 for keyboardが
        // 表示されるので、以下の numbersAndPunctuation に変更した。
        textField1.keyboardType = UIKeyboardType.numbersAndPunctuation
        textField2.keyboardType = UIKeyboardType.numbersAndPunctuation
    }

    
    // 【Swift】Segmented Controlの使い方。選択肢の中からどれか1つを選択するボタンを作る。
    // https://hajihaji-lemon.com/swift/segmented-control/
    // 【Swift 】Segmented Controlを使おう
    // https://qiita.com/littleossa/items/49bd25d646bd696d24dd
    // 【Swift5】Segmented Controllerの使い方〜超初心者にもわかるようにたくさん画像を使っています。〜
    // https://satoriku.com/segmented-controller/
    //　SegmentedControllerで選択されている算術演算子を選定
    @IBAction func actionSegmentedControl(_ sender: UISegmentedControl) {
        // 選択されたボタンのタイトルを取得する
        calculateArithmetic = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        //print( "'" , calculateArithmetic, "'" )
    }
        
    // 計算開始ボタンのクリックにより、選択演算子により掲載後、ラベルに計算結果を表示する。
    @IBAction func calculationStart(_ sender: Any) {
        
        // 本関数で使用する変数の設定と初期化
        var totalData: Double = 0.0
        var hensuData_1: Double = 0.0
        var hensuData_2: Double = 0.0
        
        print( "選択演算子：'" , calculateArithmetic, "'" )
        print( "hensu_1 =", textField1.text! , " hensu_2 =", textField2.text! )
        
        // テキストフィールドに入力文字がある場合は、数値に変換する。
        if textField1.text! != "" {
            hensuData_1 = Double( textField1.text! )!
        }
        if textField2.text! != "" {
            hensuData_2 = Double( textField2.text! )!
        }
        
        // SegmentedControlで選択された演算子により計算
        if calculateArithmetic == "＋" {
            totalData = hensuData_1 + hensuData_2
        }
        if calculateArithmetic == "ー" {
            totalData = hensuData_1 - hensuData_2
        }
        if calculateArithmetic == "×" {
            totalData = hensuData_1 * hensuData_2
        }
        if calculateArithmetic == "÷" && hensuData_2 != 0 {
            totalData = hensuData_1 / hensuData_2
        }
        
        // 計算結果表示用のラベルに表示
        if calculateArithmetic != "÷" { //}&& hensuData_2 != 0 {
            calculationResultLabel.text = "計算結果：" + String( totalData )
        // 除数が０の場合
        } else if hensuData_2 != 0 {
            calculationResultLabel.text = "計算結果：" + String( totalData )
        } else {
            calculationResultLabel.text = "割る数には０以外を入力して下さい"
        }
        
    }
    
    //↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
        //  【Swift】キーボードと一緒にViewも上げる方法
        //  https://orangelog.site/swift/slide-view-with-keyboard/
        @objc func keyboardWillShow(notification: NSNotification) {
            // 今回は、Viewを上げないように以下をコメントアウトした。
    //        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
    //            if self.view.frame.origin.y == 0 {
    //                self.view.frame.origin.y -= keyboardSize.height
    //            } else {
    //                let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
    //                self.view.frame.origin.y -= suggestionHeight
    //            }
    //        }
        }
        
        @objc func keyboardWillHide() {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
        
        @objc func dismissKeyboard() {
            self.view.endEditing(true)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

