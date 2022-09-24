//
//  Utilities.swift
//  Twittor
//
//  Created by Simon Peter Ojok on 23/09/2022.
//

import UIKit

class Utilities {
    
    static func inputContainerView(withImage image: UIImage?, textField: UITextField) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let iv = UIImageView()
        iv.image = image
        
        view.addSubview(iv)
        
        iv.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            paddingLeft: 8,
            paddingBottom: 8
        )
        iv.setDimensions(width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(
            left: iv.rightAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 8,
            paddingBottom: 8
        )
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 8,
            height: 0.75
        )
        
        return view
    }
    
    static func textField(withPlaceHolder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        return tf
    }
    
    static func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(
            string: firstPart, attributes: [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.white
            ])
        
        attributedTitle.append(NSAttributedString(
            string: secondPart,
            attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white]
        ))
        return button
    }
}
