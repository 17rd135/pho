//
//  memo.swift
//  photo
//
//  Created by 津吹陸 on 2019/06/24.
//  Copyright © 2019 津吹陸. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class memo: Object {
    @objc dynamic var year = 0
    @objc dynamic var semester = ""
    @objc dynamic var date_num = 0
    @objc dynamic var jugyou_name = ""
    @objc dynamic var number_times = 0
    @objc dynamic var memo = ""
    @objc dynamic var url = ""
}
