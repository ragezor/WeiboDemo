//
//  UserData.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/7.
//  Copyright © 2020 ragezor. All rights reserved.
//
import Combine
//环境对象
class UserData: ObservableObject {
  @Published  var  recommendPostList : PostList = loadPostListData(fileName: "PostListData_recommend_1.json")
  @Published  var hotPostList : PostList = loadPostListData(fileName: "PostListData_hot_1.json")
    
    private var recommendPostDic : [Int : Int] = [:]// id : index
    private var hotPostDic : [Int : Int] = [:]
    
    init() {
        // 取不到右端点
        for i in 0..<recommendPostList.list.count{
            let post = recommendPostList.list[i]
            recommendPostDic[post.id] = i
            }
        
        for i in 0..<hotPostList.list.count{
        let post = hotPostList.list[i]
        hotPostDic[post.id] = i
        }
        
    }
    
}
enum PostListCategory{
//    推荐内容和热门
    case  recommend
    case  hot
}
extension UserData{
    func postList(for category : PostListCategory) -> PostList{
        switch category {
        case .recommend:
            return recommendPostList
        case .hot :
            return hotPostList
        }
    }
    
    func post(forId id : Int) -> Post? {
        if let index = recommendPostDic[id]{
            return recommendPostList.list[index]
        }
        
        if let index = hotPostDic[id]{
            return hotPostList.list[index]
        }
        return nil
        
    }
    
    func update(_ post : Post){
        if let index = recommendPostDic[post.id]{
            recommendPostList.list[index] = post
        }
        if let index = hotPostDic[post.id]{
                   hotPostList.list[index] = post
               }
        
    }
}
