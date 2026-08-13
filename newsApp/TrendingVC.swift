import UIKit
import SDWebImage

class TrendingVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var newsList: [News] = []
    var currentPage = 1
    let pageSize = 15

    var isLoading = false
    var hasMoreData = true
    let spinner = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        setupSpinner()
        showSpinner()

        getTrending()
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
    

    func getTrending() {
        
        
        guard !isLoading else { return }

        isLoading = true

        APIService.shared.getTrendingNews(
            page: currentPage,
            pageSize: pageSize
        ) { data in

            if self.currentPage == 1 {
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


extension TrendingVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellTd", for: indexPath) as! TableViewCellTd

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
extension TrendingVC : UITableViewDelegate {
    
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

           getTrending()
        }
    }
}
