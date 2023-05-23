//
//  ComicContentViewController.swift
//  AppTruyenTranh
//
//  Created by Huy on 17/05/2023.
//

import UIKit
import Kingfisher

class ComicContentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let contentView = UIView()
    let tblComicContent = UITableView()
    
    var data: comic?
    
    @IBOutlet weak var imgLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblComicContent.register(UINib(nibName: "ComicTableViewCell", bundle: nil), forCellReuseIdentifier: "cellComicID")
        customComicContentScreen()
    }
    func customComicContentScreen() {
        contentView.contentMode = .scaleAspectFit
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemGray6
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: view.frame.height/8),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])
        tblComicContent.contentMode = .scaleAspectFit
        tblComicContent.dataSource = self
        tblComicContent.delegate = self
        tblComicContent.translatesAutoresizingMaskIntoConstraints = false
        tblComicContent.backgroundColor = .systemGray6
        contentView.addSubview(tblComicContent)
        NSLayoutConstraint.activate([
            tblComicContent.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,constant: 10),
            tblComicContent.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tblComicContent.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            tblComicContent.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9)
        ])
        
    }

    @IBAction func btnReturnHomeScreen(_ sender: UIButton) {
        if let homeVC = navigationController?.viewControllers.first(where: { $0 is HomeViewController }) as? HomeViewController {
            navigationController?.popToViewController(homeVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellComicID", for: indexPath) as! ComicTableViewCell
        let url = URL(string: data!.image)
        cell.imgComic.kf.setImage(with: url)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }
}
