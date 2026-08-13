//
//  SaveVC.swift
//  newsApp
//
//  Created by enjay on 22/06/26.
//

import UIKit
import SDWebImage

class SaveVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var savedNews: [News] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyVibrantGradientBackground()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            savedNews = SavedNewsManager.shared.getSavedNews()
            tableView.reloadData()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return savedNews.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellSv", for: indexPath) as! TabelViewCellSv

            let item = savedNews[indexPath.row]

            cell.titleLabel.text = item.title
            cell.sourceLabel.text = item.source.name
            cell.dateLabel.text = item.publishedAt

            if let url = item.urlToImage {
                cell.newsImage.sd_setImage(with: URL(string: url))
            }

            return cell
        }

        func tableView(_ tableView: UITableView,
                       commit editingStyle: UITableViewCell.EditingStyle,
                       forRowAt indexPath: IndexPath) {

            if editingStyle == .delete {

                SavedNewsManager.shared.removeNews(at: indexPath.row)

                savedNews.remove(at: indexPath.row)

                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewsDetailVC") as! NewsDetailVC

               vc.newsItem = savedNews[indexPath.row]
        

               navigationController?.pushViewController(vc, animated: true)
print("called")
        
    }
    
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


