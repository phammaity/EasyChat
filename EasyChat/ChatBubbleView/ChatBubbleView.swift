//
//  BaseChatMessageCell.swift
//  Consultation
//
//  Created by Ty Pham on 14/02/2023.
//

/**How to use this view
 Please refer to LeftChatMessageCell and RightChatMessageCell
 **/
import UIKit

class ChatBubbleView: UITableViewCell {
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var statusImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor.black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var bottomStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4.0
        view.alignment = .bottom
        return view
    }()
    
    var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4.0
        view.alignment = .trailing
        return view
    }()
    
    var bubbleView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    var contentMessageView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    var messageView: ChatMessageTextView = {
        let view = ChatMessageTextView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupUI(model: Message) {
        timeLabel.text = "model.dateTimeString"
        messageView.text = model.data
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    

    func commonInit() {
        transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        selectionStyle = .none
        contentMessageView.addSubview(messageView)
        mainStackView.addArrangedSubview(contentMessageView)
        mainStackView.addArrangedSubview(bottomStackView)
        bottomStackView.addArrangedSubview(timeLabel)
        bottomStackView.addArrangedSubview(statusImage)
        
        bubbleView.addSubview(mainStackView)
        contentView.addSubview(bubbleView)
        
        statusImage.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }

        messageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        contentMessageView.snp.makeConstraints { make in
            make.bottom.equalTo(messageView.snp.bottom)
        }
        bubbleView.layer.cornerRadius = 8.0
    }
}
