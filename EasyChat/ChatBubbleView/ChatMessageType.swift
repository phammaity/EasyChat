//
//  ChatMessageType.swift
//  Consultation
//
//  Created by Ty Pham on 15/02/2023.
//

import Foundation
import UIKit

enum ChatMessageType {
    case text(value: String)
    case image(value: String)
    
    func content(isMine: Bool) -> UIView {
        switch self {
        case .text(let value):
            return textView(value: value, isMine: isMine)
        case .image(let value):
            return imageView(value: value)
        }
    }
    
    var padding: CGFloat {
        switch self {
        case .image:
            return 8.0
        default:
            return 12.0
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .image:
            return 12.0
        default:
            return 8.0
        }
    }
    
    private func textView(value: String, isMine: Bool) -> ChatMessageTextView {
        let view = ChatMessageTextView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = value
        view.setupUI(isMine: isMine)
        return view
    }
    
    private func imageView(value: String) -> ImageMessageView {
        let view = ImageMessageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupData(image: value)
        return view
    }
}
