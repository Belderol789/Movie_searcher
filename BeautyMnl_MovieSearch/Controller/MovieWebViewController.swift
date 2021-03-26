//
//  MovieWebViewController.swift
//  BeautyMnl_MovieSearch
//
//  Created by iOSDev on 3/25/21.
//

import UIKit
import WebKit

class MovieWebViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieWebView: WKWebView!
    @IBOutlet weak var movieCloseButton: UIButton!
    
    // MARK: - Variables
    var selectedMovie: Movie? = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Custom Functions
    private func setupUI() {
        if let movie = self.selectedMovie {
            let url = "https://www.imdb.com/title/\(movie.imdbID)/"
            movieTitleLabel.text = movie.Title
            loadURL(with: url)
        }
    }
    
    private func loadURL(with formattedURL: String) {
        if let url = URL(string: formattedURL) {
            let request = URLRequest(url: url)
            movieWebView.load(request)
        }
    }
    
    // MARK: - IBActions
    @IBAction func closeMovieBtnTUI(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
