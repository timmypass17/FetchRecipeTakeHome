//
//  CardListView.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/30/25.
//

import SwiftUI

struct CardListView: View {
    var recipes: [Recipe]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(Array(recipes.enumerated()), id: \.offset) { index, recipe in
                            CardView(recipe: recipe, index: index)
                                .id(index) // for scrollTo()
                                .frame(width: geometry.size.width)
                                .visualEffect { content, geometryProxy in
                                    content
                                        .scaleEffect(
                                            scale(geometryProxy),
                                            anchor: .trailing)
                                        .offset(x: minX(geometryProxy)) // stacks them on top of eachother
                                        .offset(x: excessMinX(geometryProxy, offset: 8))
                                }
                                .zIndex(recipes.zIndex(recipe)) // to fix flipped deck overlapping
                        }
                    }
                    .padding(.vertical, 15) // avoid top clipping when rotating
                }
                .scrollTargetBehavior(.paging)  // swipe to snap when scrolling
                .scrollIndicators(.hidden)
            }
        }
    }
    
    private func minX(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX < 0 ? 0 : -minX
    }
    
    private func progress(_ proxy: GeometryProxy, limit: CGFloat = 2) -> CGFloat {
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        let progress = (maxX / width) - 1.0
        let cappedProgress = min(progress, limit)
        
        return cappedProgress
    }
    
    private func scale(_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
        let progress = progress(proxy)
        return 1 - (progress * scale)
    }
    
    private func excessMinX(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
        let progress = progress(proxy)
        return progress * offset
    }
    
    private func rotation(_ proxy: GeometryProxy, rotation: CGFloat = 5) -> Angle {
        let progress = progress(proxy)
        return Angle(degrees: progress * rotation)
    }
}

extension [Recipe] {
    func zIndex(_ recipe: Recipe) -> CGFloat {
        if let index = firstIndex(where: { $0.id == recipe.id }) {
            return CGFloat(count) - CGFloat(index)
        }
        
        return .zero
    }
}

//
//#Preview {
//    CardListView()
//}
