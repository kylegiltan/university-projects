//
//  EventsPhotosCollectionViewCellTwo.swift
//  TripAdvisor
//
//  Created by Kyle Gil Tan on 12/8/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import UIKit

class EventsPhotosCollectionViewCellTwo: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo: Photo!{
        didSet{
            photoImageView.image = photo.image
        }
    }
}
