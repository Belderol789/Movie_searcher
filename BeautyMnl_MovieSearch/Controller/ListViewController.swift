//
//  ViewController.swift
//  BeautyMnl_MovieSearch
//
//  Created by iOSDev on 3/23/21.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var searchField: UITextField!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var searchIdentifierLabel: UILabel!
    
    lazy var loadingView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.hidesWhenStopped = true
        activityView.color = .systemBlue
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        return activityView
    }()
    
    // MARK: - Variables
    let listViewModel: ListViewModel = ListViewModel()
    var movies: [Movie] = []
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListViewModel()
        setupListControllerUI()
    }
    
    // MARK: - Contoller Functions
    private func setupListControllerUI() {
        searchField.delegate = self
        movieCollectionView.backgroundColor = .clear
        movieCollectionView.register(MovieCVC.nib, forCellWithReuseIdentifier: MovieCVC.className)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }
    
    private func setupListViewModel() {
        listViewModel.delegate = self
        listViewModel.retrievListOfMovies(searchText: "batman")
        loadingView.startAnimating()
    }
    
    // MARK: - IBAction
    @IBAction func movieSearchTUI(_ sender: UIButton) {
        searchMovieList()
    }
}

// MARK: - UICollectionviewDelegate
extension ListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewHeight = collectionView.frame.size.height
        let collectionViewWidth = collectionView.frame.size.width
        let cellSize: CGSize = indexPath.item == 0 ? CGSize(width: collectionViewWidth / 1.4, height: collectionViewHeight / 1.5) : CGSize(width: collectionViewWidth / 3, height: collectionViewHeight / 3)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
// MARK: - UICollectionviewDatasource
extension ListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCVC = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCVC.className, for: indexPath) as! MovieCVC
        movieCVC.setupMovieCell(movie: movies[indexPath.item])
        return movieCVC
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.item]
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let webVC = mainStoryboard.instantiateViewController(identifier: "MovieWebViewController") as? MovieWebViewController else { return }
        webVC.selectedMovie = selectedMovie
        self.present(webVC, animated: true, completion: nil)
    }
}

// MARK: - UITextfieldDelegate
extension ListViewController: UITextFieldDelegate {
    // Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovieList()
        return true
    }
    
    private func searchMovieList() {
        if let searchText = searchField.text {
            searchIdentifierLabel.text = "Current searching for: \(searchText.uppercased())"
            listViewModel.retrievListOfMovies(searchText: searchText)
            searchField.resignFirstResponder()
            loadingView.startAnimating()
        }
    }
}

// MARK: - ListViewModelProtocol
extension ListViewController: ListViewModelProtocol {
    
    func returnListOfMovies(_ movies: [Movie]) {
        self.movies = movies
        loadingView.stopAnimating()
        movieCollectionView.reloadData()
    }
    
    func returnEmptyMovieList() {
        loadingView.stopAnimating()
        self.showAlertPopup(title: "No search results", message: "We're sorry, there are currently no movies based on your search", style: .alert, actions: [UIAlertAction(title: "OK", style: .cancel, handler: nil)])
    }
}
