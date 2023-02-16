//
//  Kingsher+Extension.swift
//  PorttoPre
//
//  Created by Shane on 2023/2/16.
//

import Foundation
import UIKit
import Kingfisher
import SVGKit

extension UIImageView {
    func setKingFisherImage(url: URL?, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        guard let url = url else {
            return
        }
        
        if let extenedProcesser = ExtendedImageProcessor(fileExt: url.pathExtension) {
            kf.setImage(with: url, options: [.processor(extenedProcesser)]) { result in
                completionHandler?(result)
            }
        } else {
            kf.setImage(with: url) { result in
                completionHandler?(result)
            }
        }
    }
}

struct ExtendedImageProcessor: ImageProcessor {
 
    private let fileExt: FileExt
    
    var identifier: String {
        "com.appidentifier.webpprocessor"
    }
    
    init?(fileExt: String?) {
        guard let fileExt = FileExt(rawValue: fileExt ?? "") else {
            return nil
        }
        self.fileExt = fileExt
    }
    
    func process(item: Kingfisher.ImageProcessItem, options: Kingfisher.KingfisherParsedOptionsInfo) -> Kingfisher.KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            return image
        case .data(let data):
            switch fileExt {
            case .svg:
                return SVGKImage(data: data)?.uiImage
            }
        }
    }
}

extension ExtendedImageProcessor {
    enum FileExt: String {
        case svg
    }
}
