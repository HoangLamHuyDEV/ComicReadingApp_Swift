//
//  HomeViewController.swift
//  AppTruyenTranh
//
//  Created by Huy on 09/05/2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var clvUpdatedComic: UICollectionView!
    
    @IBOutlet weak var clvRatingComic: UICollectionView!
    @IBOutlet weak var ViewHome: UIView!
    let tbxSearch = UITextField(frame: CGRect(x: 50, y: 150, width: 300, height: 50))
    var data:[comic] = []
    let insetsSession = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let insetsSessionRating = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    let itemPerRow:CGFloat = 2
    let itemPerRowRating:CGFloat = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customHomeView()
        clvUpdatedComic.dataSource = self
        clvUpdatedComic.delegate = self
        clvRatingComic.delegate = self
        clvRatingComic.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        clvRatingComic.collectionViewLayout = layout
        createData()
    }
    
    func customHomeView() {
        navigationController?.isNavigationBarHidden = true
        self.view.addSubview(tbxSearch)
        
        let searchIcon = UIImage(named: "search")
        tbxSearch.placeholder = "Tìm kiếm truyện"
        tbxSearch.backgroundColor = .white
        tbxSearch.textAlignment = .natural
        tbxSearch.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        tbxSearch.layer.cornerRadius = 20
        tbxSearch.layer.borderWidth = 1
        tbxSearch.leftView = UIImageView(image: searchIcon)
        tbxSearch.leftViewMode = .unlessEditing
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == clvUpdatedComic){
            return data.count
        }else{
            return 5
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == clvUpdatedComic){
            let cell = clvUpdatedComic.dequeueReusableCell(withReuseIdentifier: "cellComicID", for: indexPath) as! ComicCollectionViewCell
            cell.lblComicName.text = data[indexPath.row].name
            cell.lblChapter.text = "Số chương: \(data[indexPath.row].chapter)"
            cell.lblRating.text = "Đánh giá: \(data[indexPath.row].rating)"
            cell.lblUpdateDate.text = data[indexPath.row].updateDate
            let comicImgURL = URL(string: data[indexPath.row].image)
            cell.imgComic.kf.setImage(with: comicImgURL)
            return cell
        }else {
            let cell = clvRatingComic.dequeueReusableCell(withReuseIdentifier: "cellRatingComicID", for: indexPath) as! RatingComicCollectionViewCell
            let imgURL = URL(string: data[indexPath.row].image)
            cell.imgRatingComic.kf.setImage(with: imgURL)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == clvUpdatedComic) {
            let paddingSpacing = CGFloat(itemPerRow + 1) * insetsSession.left
            let availableWidth = view.frame.width - paddingSpacing
            let width = availableWidth/itemPerRow
            return CGSize(width: width-1, height: width*1.3 )
        }else{
            let paddingSpacing = CGFloat(itemPerRowRating+1) * insetsSessionRating.left
            let availableWidth = view.frame.width - paddingSpacing
            let width = availableWidth/itemPerRowRating
            return CGSize(width: width, height: width*1.3 )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if (collectionView == clvUpdatedComic) {
            return insetsSession
        }else{
            return insetsSessionRating
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if (collectionView == clvUpdatedComic) {
            return insetsSession.left
        }else{
            return insetsSessionRating.left
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let comicPageVC = storyboard?.instantiateViewController(withIdentifier: "VCComicPageID") as! ComicPageViewController
            comicPageVC.data = data[indexPath.row]
            navigationController?.pushViewController(comicPageVC, animated: true)

    }
    
    func createData () {
        let fisrtComic = comic(name: "Truyện 1", chapter: 12, rating: 3.4, updateDate: "10/5/2023", image: "https://i.pinimg.com/originals/89/3a/ab/893aab40ec160f8bbe7c17dece1c9d4d.jpg")
        let secondComic = comic(name: "Truyện 2", chapter: 20, rating: 4.5, updateDate: "11/5/2023", image: "https://i.pinimg.com/564x/18/c4/30/18c430a599ab62aebfcafd6382c7df27.jpg")
        let thirdComic = comic(name: "Truyện 3", chapter: 122.5, rating: 3.4, updateDate: "5/5/2023", image: "https://i.pinimg.com/736x/ca/1d/0e/ca1d0e2825a7ca0522b0e4bd1249f0f9.jpg")
        let fourthComic = comic(name: "Truyện 4", chapter: 12.5, rating: 4.4, updateDate: "7/5/2023", image: "https://i.pinimg.com/564x/2e/49/59/2e495968ad2fbb1e394f477e5ee78a10.jpg")
        let fifthComic = comic(name: "Truyện 5", chapter: 78.5, rating: 3.9, updateDate: "1/5/2023", image: "https://i.pinimg.com/564x/d1/c5/48/d1c548e6b8c5371e048c7a93f5617b58.jpg")
        let sixthComic = comic(name: "Truyện 6", chapter: 56.6, rating: 1.2, updateDate: "10/5/2023", image: "https://i.pinimg.com/564x/af/d3/9a/afd39a1f9a4b2a5858b9eec1a99ce6b8.jpg")
        data.append(fisrtComic)
        data.append(secondComic)
        data.append(thirdComic)
        data.append(fourthComic)
        data.append(fifthComic)
        data.append(sixthComic)
        clvUpdatedComic.reloadData()
    }
    
}
public struct comic {
    var name: String
    var chapter : Float
    var rating : Float
    var updateDate : String
    var image : String
}
