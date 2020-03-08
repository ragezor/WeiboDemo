//
//  PostCell.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/4.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI

struct PostCell: View {
    let post:Post
    
    var body: some View {
        
        
        VStack(alignment: .leading ,spacing:  10){
            

                    
                    //Vstack使得垂直布局,ledaing左对齐，Hstack水平
                    HStack(spacing:5){
                
            //            Image用于展示图像 ，初始化一个Image需要一个参数uiiamge，创建uiImage需要图片的名字，！我现在确信它非空
                        post.avatarImage
                            .resizable()//可缩放
                            .scaledToFit()//缩放成比例
                            .frame(width:50,height: 50)//宽高都是50
                            .clipShape(Circle())//裁成圆形
            //                画v
                            .overlay(
                                PostVIPBadge(vip :post.vip)
            //                        偏移量
                                    .offset(x:16,y:16)
                                )
                        
                        
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(post.name)
                                 .font(Font.system(size: 16))
                                 .foregroundColor(Color(red: 242/255, green: 99/255, blue:4/255 ))
                                 .lineLimit(1)
                            
                            Text(post.date)
                                     //这个.system前边没有Font是因为xcode根据语境自己会推断，下同
                                     .font(Font.system(size: 11))
                                     .foregroundColor(.gray)
                             }
                        .padding(.leading,10)
                        
                        if !post.isFollowed{
                              //spacor用来占位的 有多少占多少 看不见的
                                        Spacer()
                            //            button自带点击变色效果 自带判断功能是否有效
                                        Button(action: {
                            //                打印在控制台，live preivew是没有的 右键debug才会输出
                                        
                                            print("click follow button")
                                                              
                                                           }) {
                                                               Text("关注")
                                                                   .font(.system(size: 14))
                                                                   .foregroundColor(.orange)
                                                                   .frame(width: 50, height: 26)
                                                                   .overlay(
                                                                       RoundedRectangle(cornerRadius: 13)
                                                                           .stroke(Color.orange, lineWidth: 1)
                                                               )
                                                           }
                                            //单独点击
                        .buttonStyle(BorderlessButtonStyle())
                                            }

                        }
            
            Text(post.text)
                .font(.system(size:17))
            //有图片  UIScreen.main.bounds.width获取屏幕宽度 再减去两边30
           if !post.images.isEmpty{
            PostImageCell(images: post.images, width: UIScreen.main.bounds.width - 30)
            }
//            分割线
            Divider()
            
            HStack(spacing: 0){
                Spacer()
                
                PostCellToolbarButton(image :"message", text: post.commentCountText, color: .black )
                {
                    print("click comment button")
                }
                Spacer()
                PostCellToolbarButton(image :"heart", text: post.likeCountText, color: .black )
                               {
                                   print("click like button")
                               }
                Spacer()
            }
//            自制的分割线
            Rectangle()
                .padding(.horizontal, -15)
                .frame(height: 10)
                .foregroundColor(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
            
                 
         }
        .padding(.horizontal,15)
        .padding(.top, 15)
    }
}
     
        
    


struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        //快捷键 control+command+点击就可以d跳转定义 postlist的list变量
        PostCell(post:postList.list[0])
    }
}
