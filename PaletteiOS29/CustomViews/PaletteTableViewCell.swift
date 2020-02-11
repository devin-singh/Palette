//
//  PaletteTableViewCell.swift
//  PaletteiOS29
//
//  Created by Devin Singh on 2/11/20.
//  Copyright © 2020 Darin Armstrong. All rights reserved.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {
    
    var photo: UnsplashPhoto? {
        didSet {
            updateViews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    func updateViews() {
        guard let photo = photo else { return }
        fetchImage(photo: photo)
        fetchColors(photo: photo)
        paletteTitleLabel.text = photo.description
    }
    
    // MARK: - Create Subviews
    
    // lazy means that it doesn't run until it's called
    lazy var paletteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = (contentView.frame.height/20)
        
        return imageView
    }()
    
    lazy var paletteTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var colorPaletteView: ColorPaletteView = {
        let colorPaletteView = ColorPaletteView()
        return colorPaletteView
    }()
    
    // MARK: - Private Functions
    
    func addSubviews() {
        self.addSubview(paletteImageView)
        self.addSubview(paletteTitleLabel)
        self.addSubview(colorPaletteView)
    }
    
    func setupViews() {
        addSubviews()
        
        let imageDimensions = (contentView.frame.width - (spacingConstraints.outerHorizontalPadding * 2))
        
        paletteImageView.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: spacingConstraints.outerVerticalSpacing, bottomPadding: 0, leadingPadding: spacingConstraints.outerHorizontalPadding, trailingPadding: spacingConstraints.outerHorizontalPadding, width: imageDimensions, height: imageDimensions)
        
        paletteTitleLabel.anchor(top: paletteImageView.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: spacingConstraints.verticalObjectBuffer, bottomPadding: 0, leadingPadding: spacingConstraints.outerHorizontalPadding, trailingPadding: spacingConstraints.outerHorizontalPadding, width: nil, height: spacingConstraints.oneLineElementHeight)
        
        colorPaletteView.anchor(top: paletteTitleLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: spacingConstraints.verticalObjectBuffer, bottomPadding: spacingConstraints.outerVerticalSpacing, leadingPadding: spacingConstraints.outerHorizontalPadding, trailingPadding: spacingConstraints.outerHorizontalPadding, width: nil, height: spacingConstraints.twoLineElementHeight)
        
        colorPaletteView.clipsToBounds = true
        colorPaletteView.layer.cornerRadius = (spacingConstraints.twoLineElementHeight / 2)
    }
    
    func fetchImage(photo: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: photo) { (image) in
            DispatchQueue.main.async {
                self.paletteImageView.image = image
            }
        }
    }
    
    func fetchColors(photo: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: photo.urls.regular) { (colors) in
            DispatchQueue.main.async {
                guard let colors = colors else { return }
                self.colorPaletteView.colors = colors
            }
        }
    }
}
