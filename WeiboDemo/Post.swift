//
//  Post.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/6.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI
//微博属性实体类
//微博列表
struct  PostList:Codable {
    //结构和json对应
    var list:[Post]
    
}
//Data Model  遵循Codable协议 可编码 可解码  Identifiable id参数可以省略
struct Post: Codable, Identifiable{
    let id:Int
    let avatar: String//头像,图片名称
    let vip: Bool
    let name:String //用户昵称
    let date:String
    var  isFollowed: Bool
    let text:String
    let images:[String]//数组表示图片
    var commentCount:Int
    var likeCount:Int
    var isLiked:Bool
 

}
//扩展 因为本身opost只是datamodel和view没关系
extension Post{
       var avatarImage: Image{
            return  loadImage(name: avatar)
        }
        var commentCountText: String {
    //        分别显示评论 ，具体点赞数 或者多少多少k  .1 保留一位小数  只可读的属性 计算属性 只能获取不能赋值
            if commentCount <= 0 {return "评论"}
            if commentCount < 1000{return "\(commentCount)"}
            return String(format: "%.1fk", Double(commentCount)/1000)
        }
    //    点赞数
        var likeCountText: String {
                if likeCount <= 0 {return "点赞"}
                if likeCount < 1000{return "\(likeCount)"}
                return String(format: "%.1fk", Double(likeCount) / 1000)
            }
    
}
//全局变量
//let postList = loadPostListData(fileName: "PostListData_recommend_1.json")
//解析 通过文件名得到url 通过url得到data 通过data得到Json
func loadPostListData(fileName:String) ->PostList{
    //Bundle 文件夹 guard保证能执行xxxx否则报错
    guard let url=Bundle.main.url(forResource: fileName, withExtension: nil) else{
        fatalError("Can not find\(fileName)in main buddle")
    }
    guard let data = try? Data(contentsOf: url) else{
        fatalError("Can not find \(url)")
    }
    //把类型用作参数传递就要.self        从上面获取的数据进行解析
    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else{
        fatalError("Can not parse post list json data")
    }
    return  list
}
//函数实现传一个图片名称得到Image
func loadImage(name : String) -> Image {
    return Image(uiImage : UIImage (named : name)!)
    
}
