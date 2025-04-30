//
//  CachedAsyncImageView.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/30/25.
//

import SwiftUI

struct CachedAsyncImageView: View {
    @StateObject private var loader = ImageLoader()
    let url: URL?
    let placeholder: Image

    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                placeholder
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
        .task {
            await loader.loadImage(from: url)
        }
    }
}

@MainActor
class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let session: URLSession = {
        let cache = URLCache(memoryCapacity: 50_000_000, diskCapacity: 100_000_000, diskPath: "imageCache")
        let config = URLSessionConfiguration.default
        config.urlCache = cache
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config)
    }()

    func loadImage(from url: URL?) async {
        guard let url = url else { return }
        let request = URLRequest(url: url)

        do {
            // URLSession uses URLCache underhood (caches in-memory cache and disk cache)
            let (data, _) = try await session.data(for: request)
            if let downloadedImage = UIImage(data: data) {
                self.image = downloadedImage
            }
        } catch {
            print("Error loading image: \(error)")
        }
    }
}

//#Preview {
//    CachedAsyncImageView()
//}
