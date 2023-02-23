//
//  ImageMessageView.swift
//  Consultation
//
//  Created by Ty Pham on 16/02/2023.
//

import UIKit
import Kingfisher
import SnapKit

final class ImageMessageView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8.0
        return view
    }()
    
    var size: CGSize = CGSize(width: 250, height: 160)
    var heightConstraint: ConstraintMakerEditable?
    
    func initialize() {
        addSubview(imageView)
        self.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom)
            make.trailing.equalTo(imageView.snp.trailing)
        }
        self.imageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(self.size.width)
            heightConstraint = make.height.equalTo(self.size.height)
        }
    }
    
    func setupData(image: String) {
        self.imageView.kf.setImage(with: URL(string: image)) { result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    let ratio = value.image.size.height/value.image.size.width
                    self.size = CGSize(width: 250, height: ratio * 250)
                    self.heightConstraint?.offset(ratio * 250)
                }
            default:
                break
            }
        }
    }
}
