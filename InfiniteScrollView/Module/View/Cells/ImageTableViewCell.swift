//
//  ImageTableViewCell.swift
//  InfiniteScrollView
//
//  Created by Rodrigo De Paula on 21/10/2017.
//  Copyright © 2017 Rodrigo Campos. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var middleImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    var cellViewModel: ImageCellViewModel?
    
    static func nib() -> UINib? {
        return UINib(nibName: String(describing: ImageTableViewCell.self), bundle: nil)
    }
    
    func setViewModel(viewModel: ImageCellViewModel) {
        self.cellViewModel = viewModel
        refreshViewModel()
    }
    
    fileprivate func refreshViewModel() {
        if let images = self.cellViewModel?.images {
            for i in 0..<images.count {
                let image = images[i]
                if let imageURL = URL(string: image.url) {
                    switch (i) {
                    case 0:
                        leftImageView.af_setImage(withURL: imageURL, placeholderImage: UIImage(named: "placeholder"))
                        break
                    case 1:
                        middleImageView.af_setImage(withURL: imageURL, placeholderImage: UIImage(named: "placeholder"))
                        break
                    case 2:
                        rightImageView.af_setImage(withURL: imageURL, placeholderImage: UIImage(named: "placeholder"))
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        leftImageView.af_cancelImageRequest()
        middleImageView.af_cancelImageRequest()
        rightImageView.af_cancelImageRequest()
    }
    
    static func identifier() -> String {
        return "ImageTableViewCell"
    }
    
    static func cellHeight() -> Float {
        return ceilf(Float(UIScreen.main.bounds.width)/3.0)
    }
}
