//
//  ImageModel.swift
//  
//
//  Created by Никита on 19.07.21.
//

import UIKit
import Combine

final class ImageModel {
    
    typealias EmptyCompletion = () -> Void
    
    let url: String?
    let defaultImage: UIImage?
    
    let image: CurrentValueSubject<UIImage?, Never>
    let state: CurrentValueSubject<LoadingState, Never>
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(url: String?, defaultImage: UIImage? = UIImage(named: .defaultProduct)) {
        self.url = url
        self.defaultImage = defaultImage
        state = CurrentValueSubject<LoadingState, Never>(.none)
        image = CurrentValueSubject<UIImage?, Never>(nil)
        subscribeToHandleStateChange()
    }
    
    // MARK: Public
    
    func reset() {
        state.value = .none
        image.value = nil
    }
    
    // MARK: Loading
    
    func loadImageIfNeeded(completion: EmptyCompletion? = nil) {
        guard state.value == .none else { return }
        loadImage(completion: completion)
    }
    
    func loadImage(completion: EmptyCompletion? = nil) {
        guard let url = url, url.hasContent else {
            state.value = .failed
            completion?()
            return
        }
        state.value = .loading
//        NetworkService().loadImage(imagePath: url) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let image):
//                self.image.value = image
//                self.state.value = .loaded
//                completion?()
//            case .failure:
//                self.image.value = nil
//                self.state.value = .failed
//                completion?()
//            }
//        }
    }
    
    // MARK: Subscribers
    
    private func subscribeToHandleStateChange() {
        state
            .sink { [weak self] state in
                self?.setupDefaultImageIfNeeded()
            }
            .store(in: &subscriptions)
    }
    
    private func setupDefaultImageIfNeeded() {
        guard (state.value == .failed || state.value == .loaded) && image.value == nil else { return }
        image.send(defaultImage)
    }
}

