//
//  RightChatMessageCell.swift
//  Consultation
//
//  Created by Ty Pham on 16/02/2023.
//

/** How to use this cell
 let cell = tableView.dequeueReusableCell(withIdentifier: "RightChatMessageCell", for: indexPath) as! RightChatMessageCell
 let type = ChatMessageType.text(value: "Hallo, Selamat siang Olgo Ada keluhan apa?, Sudah coba minum paracetamol, tapi belum membaik.")
 let model = MessageModel(type: type, dateTimeString: "10:00 am", statusIcon: "icon-double-check")
 cell.setupUI(model: model)
 return cell
 */
import UIKit

final class RightChatMessageCell: ChatBubbleView {
    
    override func commonInit() {
        super.commonInit()
        timeLabel.textColor = .black
        bubbleView.backgroundColor = UIColor.lightGray
        
        bubbleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.0)
            make.trailing.bottom.equalToSuperview().offset(-12.0)
            make.leading.equalTo(mainStackView.snp.leading).offset(-12.0)
        }
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.0)
            make.trailing.bottom.equalToSuperview().offset(-12.0)
            make.width.lessThanOrEqualTo(contentView.snp.width).offset(-103)
        }
    }
}
