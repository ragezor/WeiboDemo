//
//  PostListView.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/6.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    let category : PostListCategory
   /* var postList : PostList{
        switch category {
        case .recommend:
           return  loadPostListData(fileName: "PostListData_recommend_1.json")
        case .hot:
          return  loadPostListData(fileName: "PostListData_hot_1.json")
        
        }
    }*/
    /*uikit的知识 隐藏默认分割线 init构造方法 selection那个不要系统自带灰色效果
    init(){
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
        
    }*/
    
    
    @EnvironmentObject var userData : UserData// 用环境对象就可以不赋值。因为可以父对象的Homeview里找到这个值
//    模拟器的bug 不能同一个cell多次跳转
    var body: some View {
/*        \.id唯一标识符 用数组初始化list 里边的元素会被遍历 每一次取出一个元素post生成一个postcell
        List(postList.list, id: \.id){ post in
            PostCell(post: post)
        }*/
        //上边的代码设置边距没有作用 使用foreach却可以
        List{
            //Identifiable 默认id 就不用再写
            ForEach(userData.postList(for: category).list){ post in
//                ZStack 是垂直于屏幕方向的排列
                ZStack {
                     PostCell(post: post) //点击postcell会跳转
                    NavigationLink(destination:  PostDetailView(post: post)) {
                                       EmptyView()
                                         
                                   }
                .hidden()//配合Zstack消除Navigation 没文字的时候自带的右箭头
                }
                .listRowInsets(EdgeInsets())
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        //ios 右进入
        NavigationView{
            PostListView(category: .recommend)
            //原本白的空间是给title的
            .navigationBarTitle("Title")
                //隐藏bar 但是t如果要隐藏就必须给一个标题
            .navigationBarHidden(true)
        }
        .environmentObject(UserData())
    }
}
