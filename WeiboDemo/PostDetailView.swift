//
//  PostDetailView.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/7.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI
//微博详情页
struct PostDetailView: View {
    let post: Post
    var body: some View {
        List{
            PostCell(post : post)
            .listRowInsets(EdgeInsets())
            
            ForEach(1...10, id: \.self){ i in
                Text("评论\(i)")
                
            }
        }
//            inline 小标题
        .navigationBarTitle("详情", displayMode: .inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: postList.list[0])
    }
}
