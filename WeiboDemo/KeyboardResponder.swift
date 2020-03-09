//
//  KeyboardResponder.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/9.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI
//监听键盘上弹变化
class  KeyboardResponder: ObservableObject{
//    keyboardhHeight前边有publish 变换的时候用到view都会更新
    @Published var keyboardHeight : CGFloat = 0
    var keyboardShow : Bool {keyboardHeight > 0 }
    init() {
//        构造方法
//        将键盘即将出现的时候系统会发送通知 监听者是self  收到通知后执行selector 接受指定对象 就在object里边写
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
//        j监听键盘即将隐藏的事件
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
//        移除通知的监听者 析构方法
        NotificationCenter.default.removeObserver(self)
    }
//    键盘i即将出现的时候执行 通过notification获取到键盘的高度赋值给keyboardHeight
    @objc private func keyboardWillShow(_ notification: Notification){
        guard let frame = notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as?CGRect else{
            return
        }
        keyboardHeight = frame.height
    }
    
    @objc private func keyboardWillHide(_ notification : Notification){
        keyboardHeight = 0
    }
}


