//
//  PaletteTableViewCell.swift
//  Palette
//
//  Created by Blake kvarfordt on 9/3/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {

    var unsplashPhoto: UnsplashPhoto? {
        didSet {
            updateViews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        constrainViews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        colorPaletteView.colors = [UIColor(named: "offWhite")!]
        
    }
    
    func updateViews() {
        guard let photo = unsplashPhoto else { return }
        // fetch image
        fetchAndSetImage(for: photo)
        // fetch color pallets
    }
    
    func fetchAndSetImage(for photo: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: photo) { (image) in
            DispatchQueue.main.async {
                self.paletteImageView.image = image
            }
        }
    }
    
    func fetchAndSetColors(for photo: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: photo.urls.regular) { (colors) in
            DispatchQueue.main.async {
                guard let colors = colors else { return }
                self.colorPaletteView.colors = colors
            }
        }
    }

    func addAllSubviews() {
        self.addSubview(paletteImageView)
        self.addSubview(titleLabel)
        self.addSubview(colorPaletteView)
    }
    
    func constrainViews() {
        addAllSubviews()
        let imageWidth = (contentView.frame.width - (SpacingConstants.outerHorizontalPadding * 2))
        
        paletteImageView.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstants.outerVerticalPadding, bottomPadding: 0, leadingPadding: SpacingConstants.outerHorizontalPadding, trailingPadding: SpacingConstants.outerHorizontalPadding, height: imageWidth, width: imageWidth)
        
        titleLabel.anchor(top: paletteImageView.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstants.verticalObjectBuffer, bottomPadding: 0, leadingPadding: SpacingConstants.outerHorizontalPadding, trailingPadding: SpacingConstants.outerHorizontalPadding, height: SpacingConstants.oneLineElementHeight, width: nil)
        
        colorPaletteView.anchor(top: titleLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstants.verticalObjectBuffer, bottomPadding: SpacingConstants.outerVerticalPadding, leadingPadding: SpacingConstants.outerHorizontalPadding, trailingPadding: SpacingConstants.outerHorizontalPadding, height: SpacingConstants.twoLineElementHeight)
        
        colorPaletteView.clipsToBounds = true
        colorPaletteView.layer.cornerRadius = colorPaletteView.frame.height / 2
    }
    
    lazy var paletteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var colorPaletteView: ColorPaletteView = {
        let view = ColorPaletteView()
        
        return view
    }()

}
