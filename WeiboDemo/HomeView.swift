//
//  HomeView.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/7.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI

struct HomeView: View {
//    两个leftPercent 绑定在一起了 传给子view用修饰词biding
    
    
    @State var leftPercent : CGFloat = 0 
    init(){
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
        
    }
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                HScrollViewController(pageWidth: geometry.size.width, contentSize: CGSize(width: geometry.size.width * 2, height: geometry.size.height),leftPercent: self.$leftPercent)
                {
                    HStack(spacing : 0){
                                    PostListView(category: .recommend)
                                                .frame(width : UIScreen.main.bounds.width)
                                    PostListView( category:  .hot)
                                                .frame(width : UIScreen.main.bounds.width)
                                           }
                }
                          
                
            }
          
            
/*            可滑动 滑动来操作
            ScrollView(.horizontal, showsIndicators: false ){}*/
//                忽略底部安全区域
            .edgesIgnoringSafeArea(.bottom)
           
            
            .navigationBarItems(leading:  HomeNavigationBar(leftPercent: $leftPercent))
                .navigationBarTitle("首页" , displayMode: .inline)
        }
//            适配ipad的navigationView和ipad一样
    .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserData())
    }
}
