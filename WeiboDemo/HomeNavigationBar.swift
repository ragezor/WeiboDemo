//
//  HomeNavigationBar.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/7.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI
private let kLableWidth : CGFloat=60
private let kButtonHeight : CGFloat=24
struct HomeNavigationBar: View {
//  @State  var leftPercent: CGFloat0时下划线在左 1时下划线在右 @state加上后表示这个属性是一个状态 改变后view就更新
    @Binding var leftPercent : CGFloat
    var body: some View {
        HStack(alignment : .top ,spacing: 0)
        {
            Button(action :{
                print("Click camera button")
            }){
                Image(systemName: "camera")
                .resizable()
                .scaledToFit()
                .frame(width : kButtonHeight ,height: kButtonHeight)
                .padding(.horizontal, 15)
                .padding(.top ,5)
                .foregroundColor(.black)
            }
            Spacer()
                    VStack(spacing : 3){
                    HStack(spacing : 0){
                        Text("推荐")
                        .bold()
                        .frame(width : kLableWidth, height: kButtonHeight)
                        .padding(.top, 5)
//                            透明度
                        .opacity(Double(1 - leftPercent * 0.5))
//                            tap 不会引起view改变
                        .onTapGesture {
//                            滑动效果
                            withAnimation{
                            self.leftPercent = 0
                            }
                    }
                        Spacer()
                        
                        Text("热门")
                        .bold()
                        .frame(width : kLableWidth, height: kButtonHeight)
                        .padding(.top, 5)
                            .opacity(Double(0.5 +  leftPercent * 0.5))
                        .onTapGesture {
                            withAnimation{
                                self.leftPercent = 1
                            }
                                                  
                            
                                                 
                                          }
                    }
                    .font(.system(size: 20))
            //            GemotryReader尽可能占空间 修改只用修改vstack 当然也可以使用全局变量
                        GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 2)
                        .foregroundColor(.orange)
                        .frame(width : 30, height : 4)
                        .offset(x: geometry.size.width  * (self.leftPercent - 0.5) + kLableWidth * ( 0.5 - self.leftPercent))
                }
                        .frame(height : 6)
                        
                }
            .frame(width : UIScreen.main.bounds.width * 0.5)
                   Spacer()
            
            Button(action :{
                print("Click add button")
            }){
                Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width : kButtonHeight ,height: kButtonHeight)
                .padding(.horizontal, 15)
                .padding(.top ,5)
                .foregroundColor(.orange)
            }
        }

        .frame(width : UIScreen.main.bounds.width)
}
}

struct HomeNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar(leftPercent: .constant(0))
    }
}
