//
//  HomeView.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/7.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    init(){
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
        
    }
    var body: some View {
        NavigationView{
//            可滑动 滑动来操作
            ScrollView(.horizontal, showsIndicators: false ){
                HStack(spacing : 0){
                    PostListView(category: .recommend)
                                .frame(width : UIScreen.main.bounds.width)
                    PostListView( category:  .hot)
                                .frame(width : UIScreen.main.bounds.width)
                           }
            }
//                忽略底部安全区域
            .edgesIgnoringSafeArea(.bottom)
           
            
            .navigationBarItems(leading:  HomeNavigationBar(leftPercent: 0))
                .navigationBarTitle("首页" , displayMode: .inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
