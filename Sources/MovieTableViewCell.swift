//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Christian McMullin on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie = CDMMovie() {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        movieNameLabel.text = movie.title
        ratingLabel.text = "Rating \(movie.rating)"
        overviewLabel.text = movie.overview
        CDMMovieController.fetchMovieImage(withPath: movie.posterURLString) { (image) in
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        }
    }
}
