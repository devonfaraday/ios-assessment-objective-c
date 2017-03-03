//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Christian McMullin on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {
    
    var movies = [CDMMovie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getMoviesWith(term: "Superman")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return MovieTableViewCell() }
        let movie = movies[indexPath.row]
        cell.movie = movie
        
        return cell
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        getMoviesWith(term: searchTerm)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
    
    func getMoviesWith(term: String){
        CDMMovieController.fetchMovies(withQuery: term) { (movies) in
            guard let movies = movies else { return }
            self.movies = movies
        }
    }
    
    
    
}
