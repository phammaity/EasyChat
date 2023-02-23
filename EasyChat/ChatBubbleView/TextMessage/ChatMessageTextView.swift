//
//  ChatMessageTextView.swift
//  Consultation
//
//  Created by Ty Pham on 15/02/2023.
//

import UIKit

class ChatMessageTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        backgroundColor = .clear
        dataDetectorTypes = [.link, .phoneNumber]
        isEditable = false
        isScrollEnabled = false
        delegate = self
        linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
    
    func setupUI(isMine: Bool) {
        textColor = isMine ? UIColor.white : UIColor.black
    }
}

extension ChatMessageTextView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        // TODO: doo sth with url
        print(URL.absoluteString)
        return false
    }
}
