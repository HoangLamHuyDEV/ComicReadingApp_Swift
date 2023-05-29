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
    let lblComicName = UILabel()
    let lblComicChapter = UILabel()
    let tblChapterPick = UITableView()
    let lblChapter = UILabel()
    let btnChapterPick = UIButton()
    let btnGoToNextChapter = UIButton()
    let btnGoToPreviousChapter = UIButton()
    let btnGoBack = UIButton()
    var chapter : Int = 0
    var chapterGoTo: Int = 0
    var data: comic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblComicContent.register(UINib(nibName: "ComicTableViewCell", bundle: nil), forCellReuseIdentifier: "cellComicID")
        tblChapterPick.register(ChapterTableViewCell.self, forCellReuseIdentifier: "ChapterTableViewCell")
        check()
        customComicContentScreen()
    }
    func customComicContentScreen() {
        contentView.contentMode = .scaleAspectFit
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemGray6
        tblChapterPick.isHidden = true
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: view.frame.height/12),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])
        
        lblComicName.contentMode = .scaleAspectFit
        lblComicName.translatesAutoresizingMaskIntoConstraints = false
        lblComicName.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight(rawValue: 0.5))
        contentView.addSubview(lblComicName)
        NSLayoutConstraint.activate([
            lblComicName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lblComicName.centerYAnchor.constraint(equalTo: contentView.topAnchor,constant: 70),
            lblComicName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            lblComicName.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05)
        ])
        
        lblComicChapter.contentMode = .scaleAspectFit
        lblComicChapter.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lblComicChapter)
        NSLayoutConstraint.activate([
            lblComicChapter.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lblComicChapter.topAnchor.constraint(equalTo: lblComicName.bottomAnchor,constant: -5),
            lblComicChapter.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.88),
            lblComicChapter.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05)
        ])
        
        tblComicContent.contentMode = .scaleAspectFit
        tblComicContent.dataSource = self
        tblComicContent.delegate = self
        tblComicContent.translatesAutoresizingMaskIntoConstraints = false
        tblComicContent.backgroundColor = .systemGray6
        contentView.addSubview(tblComicContent)
        NSLayoutConstraint.activate([
            tblComicContent.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,constant: 20),
            tblComicContent.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tblComicContent.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            tblComicContent.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9)
        ])
        
        lblChapter.contentMode = .scaleAspectFit
        lblChapter.translatesAutoresizingMaskIntoConstraints = false
        lblChapter.backgroundColor = .white
        lblChapter.textAlignment = .natural
        lblChapter.layer.borderWidth = 1
        lblChapter.text = "    Chương \(chapter + 1)"
        contentView.addSubview(lblChapter)
        NSLayoutConstraint.activate([
            lblChapter.centerYAnchor.constraint(equalTo: contentView.topAnchor,constant: 30),
            lblChapter.centerXAnchor.constraint(equalTo: contentView.centerXAnchor,constant:
                                                    -1 * view.frame.width / 20),
            lblChapter.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05),
            lblChapter.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25)
        ])
        btnChapterPick.contentMode = .scaleAspectFit
        btnChapterPick.translatesAutoresizingMaskIntoConstraints = false
        btnChapterPick.setImage(UIImage(named: "arrow-down"), for: .normal)
        btnChapterPick.backgroundColor = .systemGreen
        btnChapterPick.layer.borderWidth = 1
        contentView.addSubview(btnChapterPick)
        NSLayoutConstraint.activate([
            btnChapterPick.centerYAnchor.constraint(equalTo: contentView.topAnchor,constant: 30),
            btnChapterPick.leftAnchor.constraint(equalTo: lblChapter.rightAnchor),
            btnChapterPick.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05),
            btnChapterPick.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05)
        ])
        btnChapterPick.addTarget(self, action: #selector(openChapterPick), for: .touchUpInside)
      
        btnGoBack.contentMode = .scaleAspectFit
        btnGoBack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(btnGoBack)
        NSLayoutConstraint.activate([
            btnGoBack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            btnGoBack.centerYAnchor.constraint(equalTo: contentView.topAnchor,constant: 70),
            btnGoBack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            btnGoBack.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05)
        ])
        btnGoBack.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        tblChapterPick.contentMode = .scaleAspectFit
        tblChapterPick.translatesAutoresizingMaskIntoConstraints = false
        tblChapterPick.backgroundColor = .white
        contentView.addSubview(tblChapterPick)
        NSLayoutConstraint.activate([
            tblChapterPick.topAnchor.constraint(equalTo: lblChapter.bottomAnchor),
            tblChapterPick.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tblChapterPick.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            tblChapterPick.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
        ])
        tblChapterPick.dataSource = self
        tblChapterPick.delegate = self
        
        btnGoToNextChapter.contentMode = .scaleAspectFit
        btnGoToNextChapter.translatesAutoresizingMaskIntoConstraints = false
        btnGoToNextChapter.setTitleColor(.white, for: .normal)
        btnGoToNextChapter.setTitle("Chương sau", for: .normal)
        contentView.addSubview(btnGoToNextChapter)
        NSLayoutConstraint.activate([
            btnGoToNextChapter.centerXAnchor.constraint(equalTo: contentView.centerXAnchor,constant: view.frame.width/5),
            btnGoToNextChapter.topAnchor.constraint(equalTo: tblComicContent.bottomAnchor,constant: 10),
            btnGoToNextChapter.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05),
            btnGoToNextChapter.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.18)
        ])
        btnGoToNextChapter.addTarget(self, action: #selector(goToNextChap), for: .touchUpInside)
        
        btnGoToPreviousChapter.contentMode = .scaleAspectFit
        btnGoToPreviousChapter.translatesAutoresizingMaskIntoConstraints = false
        btnGoToPreviousChapter.setTitleColor(.white, for: .normal)
        btnGoToPreviousChapter.setTitle("Chương trước", for: .normal)
        contentView.addSubview(btnGoToPreviousChapter)
        NSLayoutConstraint.activate([
            btnGoToPreviousChapter.centerXAnchor.constraint(equalTo: contentView.centerXAnchor,constant: -1 * view.frame.width/5),
            btnGoToPreviousChapter.topAnchor.constraint(equalTo: tblComicContent.bottomAnchor,constant: 10),
            btnGoToPreviousChapter.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05),
            btnGoToPreviousChapter.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.18)
        ])
        btnGoToPreviousChapter.addTarget(self, action: #selector(goToPreviousChap), for: .touchUpInside)
        
        
        
    }

    @IBAction func btnReturnHomeScreen(_ sender: UIButton) {
        if let homeVC = navigationController?.viewControllers.first(where: { $0 is HomeViewController }) as? HomeViewController {
            navigationController?.popToViewController(homeVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == tblComicContent ){
           return data!.chapters[chapter].images.count
        } else {
            return data!.chapters.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == tblComicContent ){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellComicID", for: indexPath) as! ComicTableViewCell
            let url = URL(string: data!.chapters[chapter].images[indexPath.row])
            cell.imgComic.kf.setImage(with: url)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterTableViewCell", for: indexPath) as! ChapterTableViewCell
            cell.textLabel?.text = "Chapter \(indexPath.row + 1)"
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (tableView == tblComicContent ){
            return 500
        }else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == tblChapterPick){
            pickChapter(chapterPick: indexPath.row)
            tblChapterPick.isHidden = true
        }
    }
    
    func pickChapter(chapterPick: Int){
        
        lblChapter.text = "   Chương \(chapterPick + 1)"
        lblComicChapter.text = "Chương \(chapterPick + 1)"
        chapter = chapterPick
        btnChapterPick.setImage(UIImage(named: "arrow-down"), for: .normal)
        btnChapterPick.backgroundColor = .systemGreen
        tblComicContent.setContentOffset(CGPoint.zero, animated: false)
        tblComicContent.reloadData() // reloadData()
        check()
         
    }
    
    @objc func openChapterPick(){
        if (tblChapterPick.isHidden){
            tblChapterPick.isHidden = false
            btnChapterPick.setImage(UIImage(named: "close"), for: .normal)
            btnChapterPick.backgroundColor = .systemRed
        }else {
            tblChapterPick.isHidden = true
            btnChapterPick.setImage(UIImage(named: "arrow-down"), for: .normal)
            btnChapterPick.backgroundColor = .systemGreen
        }
    }
    
    @objc func goToNextChap() {
        check()
        let tempChap = chapter
        chapterGoTo = tempChap + 1
        chapter = chapterGoTo
        pickChapter(chapterPick: chapter)
    }
    
    @objc func goToPreviousChap() {
        check()
        let tempChap = chapter
        chapterGoTo = tempChap - 1
        chapter = chapterGoTo
        pickChapter(chapterPick: chapter)
    }
    
    func check() {
        if(data!.chapters.count > 2) {
            if (chapter < data!.chapters.count-1 && chapter > 0){
                btnGoToNextChapter.isEnabled = true
                btnGoToPreviousChapter.isEnabled = true
                btnGoToPreviousChapter.backgroundColor = .systemMint
                btnGoToNextChapter.backgroundColor = .systemMint
            }else if(chapter <= 0){
                btnGoToPreviousChapter.isEnabled = false
                btnGoToPreviousChapter.backgroundColor = .systemGray4
                btnGoToNextChapter.backgroundColor = .systemMint
            }else{
                btnGoToNextChapter.isEnabled = false
                btnGoToNextChapter.backgroundColor = .systemGray4
                btnGoToPreviousChapter.backgroundColor = .systemMint
            }
        }else if (data!.chapters.count == 2){
            if (chapter == 0){
                btnGoToPreviousChapter.isEnabled = false
                btnGoToNextChapter.isEnabled = true
                btnGoToPreviousChapter.backgroundColor = .systemGray4
                btnGoToNextChapter.backgroundColor = .systemMint
            }else{
                btnGoToNextChapter.isEnabled = false
                btnGoToPreviousChapter.isEnabled = true
                btnGoToNextChapter.backgroundColor = .systemGray4
                btnGoToPreviousChapter.backgroundColor = .systemMint
            }
        }else {
            btnGoToNextChapter.isHidden = true
            btnGoToPreviousChapter.isHidden = true
        }
    }
    
    @objc func goBack () {
        navigationController?.popViewController(animated: true)
    }
}
