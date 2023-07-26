//
//  SelectedFilterTagView.swift
//  GAM
//
//  Created by Jungbin on 2023/07/25.
//

import UIKit

final class SelectedFilterTagView: UIView {
    
    // MARK: UIComponents
    
    private let titleLabel: GamSingleLineLabel = GamSingleLineLabel(text: "", font: .body1Regular, color: .gamWhite)
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setLayout()
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setUI() {
        self.backgroundColor = .gamBlack
        self.makeRounded(cornerRadius: 36 / 2)
        self.isHidden = true
    }
    
    func setTag(tags: [TagEntity]) {
        var result: String = ""
        
        switch tags.count {
        case 1:
            self.isHidden = false
            result = tags[0].name
        case 2, 3:
            self.isHidden = false
            result = "\(tags[0].name) 외 \(tags.count - 1)"
        default:
            self.isHidden = true
            return
        }
        
        self.titleLabel.text = result
        self.sizeToFit()
    }
    
    private func setLayout() {
        self.addSubview(titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.left.right.equalToSuperview().inset(14)
        }
    }
}
