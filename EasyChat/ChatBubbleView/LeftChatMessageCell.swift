//
//  LeftChatMessageCell.swift
//  Consultation
//
//  Created by Ty Pham on 16/02/2023.
//

/** How to use this cell
 let cell = tableView.dequeueReusableCell(withIdentifier: "LeftChatMessageCell", for: indexPath) as! LeftChatMessageCell
 let type = ChatMessageType.text(value: "Hallo, Selamat siang Olgo Ada keluhan apa?, Sudah coba minum paracetamol, tapi belum membaik.")
 let model = MessageModel(type: type, dateTimeString: "10:00 am", statusIcon: "icon-double-check")
 cell.setupUI(model: model)
 return cell
 */
import UIKit

final class LeftChatMessageCell: ChatBubbleView {
    
    override func commonInit() {
        super.commonInit()
        
        timeLabel.textColor = .white
        bubbleView.backgroundColor = .lightGray
        
        bubbleView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12.0)
            make.bottom.equalToSuperview().offset(-12.0)
            make.trailing.equalTo(mainStackView.snp.trailing).offset(12.0)
            
        }
        mainStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12.0)
            make.bottom.equalToSuperview().offset(-12.0)
            make.width.lessThanOrEqualTo(contentView.snp.width).offset(-103)
        }
        statusImage.isHidden = true
    }
}
