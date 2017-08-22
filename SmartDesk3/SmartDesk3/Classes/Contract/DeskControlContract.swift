//
//  ProductControlContract.swift
//  SmartDesk
//
//  Created by Trong_iOS on 5/23/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import Foundation
import AutoCommon

protocol DeskControlView: BaseView {
    func showAnimation(action: String)
    func onSavedDesk()
}

protocol DeskControlPresenter: BasePresenter {
    func sendAction(action: String, callBack: ((_ object: [String:AnyObject]?) -> (Void))?)
    func saveDeskData(data: [String : String]?)
}
