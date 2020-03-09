//
//  PostImageCell.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/7.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI
//图片间距
private let KImageSpace: CGFloat = 6
struct PostImageCell: View {
    let images: [String] //图片名称
    let width: CGFloat
    var body: some View {
        
        Group{
        if images.count == 1 {
            loadImage(name: images[0])
                                       .resizable()
                                       .scaledToFill()
                                       .frame(width:width,height: width * 0.75 )
                                       .clipped()
        }
        else if images.count == 2{
            PostImageCellRow(images: images, width: width)
            
        }
        
        else if images.count == 3{
             PostImageCellRow(images: images, width: width)
            
        }
        else if images.count == 4{
            VStack( spacing: KImageSpace){
//                每行两张 取出新的数组
                PostImageCellRow(images: Array(images[0...1]), width: width)
                PostImageCellRow(images: Array(images[2...3]), width: width)
                
            }
        }
        else if images.count == 5{
            VStack( spacing: KImageSpace){
 
                            PostImageCellRow(images: Array(images[0...1]), width: width)
                            PostImageCellRow(images: Array(images[2...4]), width: width)
                            
                        }
            
        }
        else if images.count == 6{
            VStack( spacing: KImageSpace){
        
                            PostImageCellRow(images: Array(images[0...2]), width: width)
                            PostImageCellRow(images: Array(images[3...5]), width: width)
                            
                        }
            
        }
        }
        
        
    }
}
struct  PostImageCellRow:  View {
    let images: [String]
    let width: CGFloat
    var body : some View{
        HStack(spacing : KImageSpace){
            //String自己作为id .self
            ForEach(images, id: \.self){ image in
                loadImage(name: image)
                .resizable()
                .scaledToFill()
                    //协议加self
                    .frame(width: (self.width - KImageSpace * CGFloat(self.images.count - 1)) / CGFloat(self.images.count) , height: (self.width - KImageSpace * CGFloat(self.images.count - 1) ) / CGFloat(self.images.count))
                .clipped()
                
                
            }
        }
    }
}

struct PostImageCell_Previews: PreviewProvider {
    static var previews: some View {
        //声明了局部变量就要返回返回值
        let images = UserData().recommendPostList.list[0].images
        let width=UIScreen.main.bounds.width
        //[a...b] 取数组片段
        return Group{
            PostImageCell(images: Array(images[0...0]),width: width)
             PostImageCell(images: Array(images[0...1]),width: width)
            PostImageCell(images: Array(images[0...2]),width: width)
            PostImageCell(images: Array(images[0...3]),width: width)
             PostImageCell(images: Array(images[0...4]),width: width)
             PostImageCell(images: Array(images[0...5]),width: width)

        }
       // 指定预览页的宽高
            .previewLayout(.fixed(width: width, height: 300))
    }
}
