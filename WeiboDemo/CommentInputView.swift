//
//  CommentInputView.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/9.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI

struct CommentInputView: View {
    
    let post : Post
//    系统存储的信息
    @Environment(\.presentationMode) var presentaionMode
    
    @EnvironmentObject  var userData : UserData
    
    @State private var text : String = ""
//    类似环境对象但是需要赋值a
    @ObservedObject private  var keyboardResponder = KeyboardResponder()
//    HUD 提示语
    @State private  var showEmptyTextHUD : Bool = false
    
    var body: some View {
        VStack(spacing : 0){
            
            CommentTextView(text: $text, beginEditOnAppear: true)
            
                HStack(spacing : 0){
                        Button (action:{
            //                消失莫泰页面
                            self.presentaionMode.wrappedValue.dismiss()
                        }){
                            Text("取消").padding()
                        }
                        Spacer()
                        
                        Button (action:{
//                            过滤空格回车
                            if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                                    self.showEmptyTextHUD = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                    self.showEmptyTextHUD = false
                                }
                                return
                            }
                            print(self.text)
                            var post = self.post
                            post.commentCount += 1
                            self.userData.update(post)
                                   self.presentaionMode.wrappedValue.dismiss()
                               }){
                                   Text("发送").padding()
                               }
                    }
            
        
    
        .font(.system(size: 18))
        .foregroundColor(.black)
    }
        .overlay(
        Text("评论不能为空")
//            0.5   变到1a
            .opacity(showEmptyTextHUD ? 1 : 0)
            .scaleEffect(showEmptyTextHUD ? 1 : 0.5 )
            .animation(.spring(dampingFraction: 0.5))
            //            动画开头结尾放慢速度 中间加快
            .animation(.easeInOut)
        )
        .padding(.bottom, keyboardResponder.keyboardHeight)
        .edgesIgnoringSafeArea(keyboardResponder.keyboardShow ? .bottom :[])
    }
}

struct CommentInputView_Previews: PreviewProvider {
    static var previews: some View {
        CommentInputView(post: UserData().recommendPostList.list[0])
    }
}
