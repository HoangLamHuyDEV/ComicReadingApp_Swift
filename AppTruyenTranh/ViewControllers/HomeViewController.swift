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
            cell.lblChapter.text = "Số chương: \(data[indexPath.row].chapters.count)"
            cell.lblRating.text = "Đánh giá: \(data[indexPath.row].rating)"
            cell.lblUpdateDate.text = data[indexPath.row].chapters.last?.updateDate
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
        let fisrtChapterComic:[String] = ["https://i.pinimg.com/564x/34/51/f1/3451f1f51b4a4338cf1b1b1b81371e30.jpg","https://i.pinimg.com/564x/bf/8e/ae/bf8eae58f9ee14b39306e509eebe2bf2.jpg","https://i.pinimg.com/564x/e4/19/1d/e4191d3311e1e47365caf9d8f679fbb1.jpg","https://i.pinimg.com/564x/29/ef/20/29ef20b450ebcf335d09780d02ce19fc.jpg","https://i.pinimg.com/564x/c4/e3/45/c4e3458a7f22700716acd0fb0598f7bc.jpg","https://i.pinimg.com/564x/44/5b/01/445b01db2aa8bf6766db32d04ef418bd.jpg","https://i.pinimg.com/564x/29/ef/20/29ef20b450ebcf335d09780d02ce19fc.jpg","https://i.pinimg.com/564x/17/42/df/1742df472467d9dca6b2408a62a4a563.jpg"]
        let secondChapterComic:[String] = ["https://i.pinimg.com/564x/bf/2d/68/bf2d68fb1c1457adcbcf9850ada25014.jpg","https://i.pinimg.com/564x/bf/2d/68/bf2d68fb1c1457adcbcf9850ada25014.jpg","https://i.pinimg.com/564x/34/51/f1/3451f1f51b4a4338cf1b1b1b81371e30.jpg","https://i.pinimg.com/564x/bf/8e/ae/bf8eae58f9ee14b39306e509eebe2bf2.jpg","https://i.pinimg.com/564x/e4/19/1d/e4191d3311e1e47365caf9d8f679fbb1.jpg","https://i.pinimg.com/564x/29/ef/20/29ef20b450ebcf335d09780d02ce19fc.jpg","https://i.pinimg.com/564x/03/38/55/0338552776f2bcb4fc4aa915fe642833.jpg","https://i.pinimg.com/564x/44/5b/01/445b01db2aa8bf6766db32d04ef418bd.jpg","https://i.pinimg.com/564x/29/ef/20/29ef20b450ebcf335d09780d02ce19fc.jpg","https://i.pinimg.com/564x/bf/2d/68/bf2d68fb1c1457adcbcf9850ada25014.jpg"]
        let fisrtChapter = chapter(id: "1", name: "alololo", images: fisrtChapterComic, updateDate: "12-2-2023")
        let secondChapter = chapter(id: "2", name: "hello world", images: secondChapterComic, updateDate: "2-3-2023")
        let thirdChapter = chapter(id: "3", name: "nothing is matter", images: secondChapterComic, updateDate: "1-1-2020")
        var fisrtComic = comic(id: "co1", name: "Truyện 1", rating: 2.4, image: "https://i.pinimg.com/564x/03/38/55/0338552776f2bcb4fc4aa915fe642833.jpg")
        fisrtComic.chapters.append(secondChapter)
        fisrtComic.chapters.append(fisrtChapter)
        fisrtComic.chapters.append(secondChapter)
        fisrtComic.chapters.append(fisrtChapter)
        fisrtComic.chapters.append(thirdChapter)
        fisrtComic.chapters.append(secondChapter)
        
        var secondComic = comic(id: "co2", name: "Truyện 2", rating: 4.5, image: "https://i.pinimg.com/564x/ee/f4/f7/eef4f7b4ea70155319ec4269b679c2f7.jpg")
        secondComic.chapters.append(fisrtChapter)
        secondComic.chapters.append(secondChapter)
        secondComic.chapters.append(fisrtChapter)
        secondComic.chapters.append(secondChapter)
        secondComic.chapters.append(fisrtChapter)
        secondComic.chapters.append(secondChapter)
        secondComic.chapters.append(secondChapter)
        secondComic.chapters.append(fisrtChapter)
        
        var thirdComic = comic(id: "co3", name: "Truyện 3", rating: 3.5, image: "https://i.pinimg.com/564x/dc/7b/76/dc7b76c5d55e5d9a1187b44140629a41.jpg")
        thirdComic.chapters.append(thirdChapter)
        thirdComic.chapters.append(fisrtChapter)
        thirdComic.chapters.append(secondChapter)
        thirdComic.chapters.append(fisrtChapter)
        thirdComic.chapters.append(thirdChapter)
        thirdComic.chapters.append(fisrtChapter)
        thirdComic.chapters.append(secondChapter)
        thirdComic.chapters.append(thirdChapter)
        
        var fourthComic = comic(id: "co4", name: "Truyện 4", rating: 1.5, image: "https://i.pinimg.com/564x/5a/50/77/5a5077badc077b7ab587ef7e30cfefdf.jpg")
        fourthComic.chapters.append(fisrtChapter)
        fourthComic.chapters.append(secondChapter)
        fourthComic.chapters.append(fisrtChapter)
        fourthComic.chapters.append(secondChapter)
        fourthComic.chapters.append(thirdChapter)
        fourthComic.chapters.append(fisrtChapter)
        fourthComic.chapters.append(thirdChapter)
        fourthComic.chapters.append(fisrtChapter)
        fourthComic.chapters.append(fisrtChapter)
        fourthComic.chapters.append(fisrtChapter)
        fourthComic.chapters.append(thirdChapter)
        fourthComic.chapters.append(fisrtChapter)
        fourthComic.chapters.append(fisrtChapter)
        fourthComic.chapters.append(fisrtChapter)
        fourthComic.chapters.append(secondChapter)
        fourthComic.chapters.append(secondChapter)
        
        var firthComic = comic(id: "co5", name: "Truyện 5", rating: 5.0, image: "https://i.pinimg.com/564x/b1/1b/58/b11b5857b662f0465ea1ddfe89d801a7.jpg")
        firthComic.chapters.append(fisrtChapter)
        firthComic.chapters.append(secondChapter)
        firthComic.chapters.append(fisrtChapter)
        firthComic.chapters.append(secondChapter)
        firthComic.chapters.append(fisrtChapter)
        firthComic.chapters.append(secondChapter)
        firthComic.chapters.append(thirdChapter)
        firthComic.chapters.append(thirdChapter)
        firthComic.chapters.append(thirdChapter)
        firthComic.chapters.append(secondChapter)
        firthComic.chapters.append(fisrtChapter)
        firthComic.chapters.append(secondChapter)
        firthComic.chapters.append(secondChapter)
        firthComic.chapters.append(fisrtChapter)
        firthComic.chapters.append(secondChapter)
        firthComic.chapters.append(secondChapter)
        firthComic.chapters.append(fisrtChapter)
        firthComic.chapters.append(secondChapter)
        firthComic.chapters.append(secondChapter)
        firthComic.chapters.append(fisrtChapter)
        firthComic.chapters.append(secondChapter)
        firthComic.chapters.append(secondChapter)
        firthComic.chapters.append(thirdChapter)
        
        var sixthComic = comic(id: "co6", name: "Truyện 6", rating: 3.8, image: "https://i.pinimg.com/564x/f2/b5/12/f2b5125d6a5c2c7dd635e6ea8cb210cd.jpg")
        sixthComic.chapters.append(fisrtChapter)
        sixthComic.chapters.append(secondChapter)
        
        var seventhComic = comic(id: "co7", name: "Truyện 7", rating: 3.1, image: "https://i.pinimg.com/564x/29/ef/20/29ef20b450ebcf335d09780d02ce19fc.jpg")
        seventhComic.chapters.append(thirdChapter)
        data.append(fisrtComic)
        data.append(secondComic)
        data.append(thirdComic)
        data.append(fourthComic)
        data.append(firthComic)
        data.append(sixthComic)
        data.append(seventhComic)
        clvUpdatedComic.reloadData()
    }
    
}
