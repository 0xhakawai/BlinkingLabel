//
//  DeskInfoContract.swift
//  SmartDesk3
//
//  Created by sa on 7/29/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import Foundation
import UIKit
import AutoCommon

public protocol DeskInfoView: BaseView {
    func onCheckoutCallback(_ value:Bool)

}

public protocol DeskInfoPresenter: BasePresenter{
    func checkOut()
}
