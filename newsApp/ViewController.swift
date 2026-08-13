//
//  ViewController.swift
//  newsApp
//
//  Created by enjay on 20/06/26.
//

import UIKit
import SDWebImage

class ViewController: UIViewController{
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var newsList: [News] = []
    
//    let apiSerive = APIService()
    var currentPage = 1
    var isLoading = false
    var hasMoreData = true
    let pageSize = 15
    let spinner = UIActivityIndicatorView(style: .medium)
    
    let categories = ["general","business","entertainment","health","science","sports","technology"]
    
    var selectedCategory = "sports"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        searchBar.delegate = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
        
         collectionView.showsHorizontalScrollIndicator = false
    
        setupSpinner()
        showSpinner()
        
        getNewsData(category: selectedCategory, page: currentPage)
        
    
    }
    
    func setupSpinner() {
        spinner.hidesWhenStopped = true
        tableView.tableFooterView = spinner
    }
    
    func showSpinner() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
    func getNewsData(category: String, page: Int) {

        guard !isLoading else { return }

        isLoading = true

        APIService.shared.getNews(
            category: category,
            page: page,
            pageSize: pageSize
        ) { data in

            DispatchQueue.main.async {

                if page == 1 {
                    self.newsList = data
                } else {
                    self.newsList.append(contentsOf: data)
                }

                self.hasMoreData = !data.isEmpty
                self.isLoading = false
                
                self.hideSpinner()

                self.tableView.reloadData()
            }
        }
    }
    
    
}
extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell

                let item = newsList[indexPath.row]

               cell.titleLabel.text = item.title
                cell.sourceLabel.text = item.source.name
                cell.dateLabel.text = item.publishedAt

                
                if let url = item.urlToImage {
                    cell.newsImage.sd_setImage(with: URL(string: url))
                }

                return cell
    }
    
}
extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewsDetailVC") as! NewsDetailVC

               vc.newsItem = newsList[indexPath.row]
        

               navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {

        if indexPath.row == newsList.count - 1 &&
            !isLoading &&
            hasMoreData {

            currentPage += 1
            showSpinner()

            getNewsData(
                category: selectedCategory,
                page: currentPage
            )
        }
    }
    
    
    
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
                  withReuseIdentifier: "CollectionCell",
                  for: indexPath
              ) as! CollectionCell
        
        cell.collectionCellLabel.text = categories[indexPath.row].capitalized

        return cell
    }
    
    
    
}
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedCategory = categories[indexPath.row]
        
            currentPage = 1
            hasMoreData = true
            showSpinner()
        
        getNewsData(category: selectedCategory , page: currentPage)
    }
    
}
extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let text = searchBar.text,
              !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }

        APIService.shared.searchNews(query: text) { data in

            self.newsList = data
            self.tableView.reloadData()
        }

        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {

            currentPage = 1

            getNewsData(
                category: selectedCategory,
                page: currentPage
            )
        }
    }
}
