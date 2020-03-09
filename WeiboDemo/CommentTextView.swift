//
//  CommentTextView.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/9.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI

struct CommentTextView: UIViewRepresentable {
    @Binding var text : String
//    当刚出现的时候是否编辑 用在打开评论就能进入编辑状态
    let beginEditOnAppear : Bool
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.backgroundColor = .systemGray6
        view.font = .systemFont(ofSize: 18)
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.delegate = context.coordinator
        view.text = text
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
//        还没有显示出来就要进入编辑状态的话会报错 所以判断非空  是第一响应者
        
        if beginEditOnAppear,!context.coordinator.didBecomeFirstResponder, uiView.window != nil , !uiView.isFirstResponder{
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
    
    class  Coordinator: NSObject , UITextViewDelegate {
        let parent : CommentTextView
        var didBecomeFirstResponder : Bool = false
        init(_ view : CommentTextView) {
            parent = view
        }
//        文本框文本变化的时候调用
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
    }

struct CommentTextView_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextView(text: .constant(""), beginEditOnAppear: true)
    }
}
