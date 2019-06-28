//
//  ViewController.swift
//  photo
//
//  Created by 津吹陸 on 2019/06/24.
//  Copyright © 2019 津吹陸. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    let realm = try! Realm()
    
    @IBOutlet weak var memoLabel: UITextView!
    
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
        let image = info[.originalImage] as! UIImage
        let text = memoLabel.text
        let data1 = memo()
        
        //画像のURLを取得
        if let Url = info[.imageURL] as? NSURL {
            data1.url = Url.lastPathComponent!
            data1.memo = memoLabel.text
            
            //ファイルに書き込む
            if saveImage(image: image, path: data1.url) {
                //写真のサイズ調整
                let width = image.size.width
                let scale = width / (UIScreen.main.bounds.width - 10)
                
                //UITextViewに写真を書き込む
                let attachment = NSTextAttachment()
                attachment.image = UIImage(
                    cgImage: image.cgImage!,
                    scale: scale,
                    orientation: .up)
                let imageAttribute = NSAttributedString(attachment: attachment)
                let mutableString = NSMutableAttributedString(string: text!)
                //写真の入れる位置を調整
                mutableString.insert(imageAttribute, at: 0)
                memoLabel.attributedText = mutableString
                
                try! realm.write() {
                    //受け取った授業名のlistに追加
                    realm.add(data1)
                }
            }
        }
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }

    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        return documentsURL
    }
    
    // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
    func fileInDocumentsDirectory(filename: String) -> String {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
    }
    
    //写真を指定したURLに保存する
    func saveImage (image: UIImage, path: String ) -> Bool {
        let pngImageData = image.pngData()
        let DocumentsPath = fileInDocumentsDirectory(filename: path)
        do {
            try pngImageData!.write(to: URL(fileURLWithPath: DocumentsPath), options: .atomic)
        } catch {
            print(error)
            return false
        }
        return true
    }
    
    //指定したURLのfileを削除する
    func deleteFile (path: String) {
        let DocumentsPath = fileInDocumentsDirectory(filename: path)
        do {
            try FileManager.default.removeItem(atPath: DocumentsPath)
        } catch {
            print("error")
        }
    }
    
    //入れたパスをURLにし、そのURLから写真を取り出す
    func loadImageFromPath(path: String) -> UIImage? {
        let DocumentsPath = fileInDocumentsDirectory(filename: path)
        let image = UIImage(contentsOfFile: DocumentsPath)
        if image == nil {
            print("missing image at: \(DocumentsPath)")
        }
        return image
    }
}
