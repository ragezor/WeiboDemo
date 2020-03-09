//
//  HScrollViewController.swift
//  WeiboDemo
//
//  Created by ragezor on 2020/3/8.
//  Copyright © 2020 ragezor. All rights reserved.
//

import SwiftUI
//又是个协议
struct HScrollViewController <Content : View > : UIViewControllerRepresentable {
    let pageWidth : CGFloat
    let contentSize : CGSize
    let content : Content
    @Binding var leftPercent : CGFloat
    
    init(pageWidth : CGFloat ,contentSize : CGSize ,leftPercent: Binding<CGFloat>, @ViewBuilder content : () -> Content){
        self.pageWidth = pageWidth
        self.contentSize = contentSize
        self.content = content()
        self._leftPercent = leftPercent
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    func makeUIViewController(context: Context) -> UIViewController {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled=true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = context.coordinator
        context.coordinator.scrolllView = scrollView
        
        
        let vc = UIViewController()
        vc.view.addSubview(scrollView)
//        swift ui的view添加到content 页面上
        let host = UIHostingController(rootView: content)
        vc .addChild(host)
        scrollView.addSubview(host.view)
        host.didMove(toParent: vc)
        context.coordinator.host = host
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let scrollView = context.coordinator.scrolllView!
        scrollView.frame = CGRect(x: 0, y: 0, width: pageWidth, height: contentSize.height)
        scrollView.contentSize = contentSize
        scrollView.setContentOffset(CGPoint(x: leftPercent * (contentSize.width - pageWidth), y: 0), animated: true)
        context.coordinator.host.view.frame = CGRect(origin: .zero, size: contentSize)
    }
//    uikit通常继承NSObject
    class Coordinator : NSObject , UIScrollViewDelegate{
        let parent : HScrollViewController
        var scrolllView : UIScrollView!
        var host : UIHostingController<Content>!
        
        init(_ parent : HScrollViewController) {
            self.parent = parent
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            withAnimation{
                    parent.leftPercent = scrollView.contentOffset.x < parent.pageWidth * 0.5 ? 0 : 1
            }
        
        }
        
    }
}

