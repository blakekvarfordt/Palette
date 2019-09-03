//
//  ColorPaletteView.swift
//  Palette
//
//  Created by Blake kvarfordt on 9/3/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class ColorPaletteView: UIView {
    
    var colors: [UIColor] {
        didSet {
            buildsColorBricks()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    init(colors: [UIColor] = [], frame: CGRect = .zero) {
        self.colors = colors
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(stackView)
        stackView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, topPadding: 0, bottomPadding: 0, leadingPadding: 0, trailingPadding: 0)
    }
    
    private func buildsColorBricks() {
        resetBricks()
        for color in self.colors {
            let colorBrick = self.generateColorBrick(for: color)
            self.addSubview(colorBrick)
            self.stackView.addArrangedSubview(colorBrick)
        }
        self.layoutIfNeeded()
    }

    private func generateColorBrick(for color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
    
    func resetBricks() {
        for subview in stackView.arrangedSubviews {
            self.stackView.removeArrangedSubview(subview)
        }
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()

}
