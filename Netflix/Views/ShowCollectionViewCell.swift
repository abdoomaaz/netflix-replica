//
//  ShowCollectionViewCell.swift
//  Netflix
//
//  Created by AbdooMaaz's playground on 08.05.22.
//

import UIKit
import SDWebImage

class ShowCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ShowCollectionViewCell"
    
    private let showPosterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(showPosterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        showPosterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String){
        guard let url  = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else{return}
        showPosterImageView.sd_setImage(with: url, completed: nil)
    }
}
