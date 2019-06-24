//
//  ViewController.swift
//  photo
//
//  Created by 津吹陸 on 2019/06/24.
//  Copyright © 2019 津吹陸. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let label = UILabel()
        view.addSubview(label)
        label.textAlignment = .center
        label.frame.size = .init(width: view.bounds.width-20, height: 50)
        label.center = view.center
        label.font = .systemFont(ofSize: 30)
        
        let text = "labelに犬を表示する"
        let image = UIImage(named: "dog.jpg")!
        let font = label.font!
        let size = CGSize(width: 30, height: 30)
        
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let y = (font.capHeight-size.height).rounded() / 2
        attachment.bounds.origin = CGPoint(x: 0, y: y)
        attachment.bounds.size = size
        
        let imageAttribute = NSAttributedString(attachment: attachment)
        let mutableString = NSMutableAttributedString(string: text)
        mutableString.insert(imageAttribute, at: text.count)
        
        label.attributedText = mutableString
    }
    
    @IBAction func save(_ sender: Any) {
        // 写真を選ぶビュー
        let ipc = UIImagePickerController()
        ipc.delegate = self
        // 写真の選択元をカメラロールにする
        ipc.sourceType = .photoLibrary
        //編集を可能にする
        ipc.allowsEditing = true
        // ビューに表示
        self.present(ipc,animated: true, completion: nil)
    }
    
    
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        /*let data1 = Diary()
        //画像のイメージを取得
        let img = info[.originalImage] as! UIImage
        
        //画像のURLを取得
        if let Url = info[.imageURL] as? NSURL {
            data1.id = ids
            data1.url = Url.lastPathComponent!
            //ファイルに書き込む
            if saveImage(image: img, path: data1.url) {
                try! realm.write() {
                    //受け取った授業名のlistに追加
                    jugyou.dairys.append(data1)
                }
            }
        }*/
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }


}

