//
//  PostCellToolbarButton.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/6.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI

struct PostCellToolbarButton: View {
    let image: String
    let text: String
    let color: Color
    let action: () -> Void//closure,闭包
    var body: some View {
        Button(action: action ){
            HStack(spacing: 5){
                Image(systemName: image)
                .resizable()
//                用fit 适应 不填充
                .scaledToFit()
                .frame(width: 18, height: 18)
                Text(text)
                    .font(.system(size: 15))
            }
        }
        .foregroundColor(color)
         .buttonStyle(BorderlessButtonStyle())
    }
}

struct PostCellToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        PostCellToolbarButton(image: "heart", text: "点赞", color: .red){
            print("点赞")
        }
    }
}
