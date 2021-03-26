//
//  MovieCVC.swift
//  BeautyMnl_MovieSearch
//
//  Created by iOSDev on 3/24/21.
//

import UIKit
import SDWebImage

class MovieCVC: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieYearText: UILabel!
    @IBOutlet weak var movieTitleText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupMovieCell(movie: Movie?) {
        guard let movie = movie else { return }
        if let url = URL(string: movie.Poster) {
            moviePoster.contentMode = .scaleAspectFill
            moviePoster.sd_setImage(with: url, placeholderImage: nil, options: .continueInBackground, context: nil)
        }
        movieTitleText.adjustsFontSizeToFitWidth = true
        movieTitleText.text = movie.Title
        movieYearText.text = movie.Year
    }
}
