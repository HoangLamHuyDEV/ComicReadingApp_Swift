import UIKit
import Kingfisher

class ComicPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var data: comic?
    let scrollView = UIScrollView()
    let comicImageView = UIImageView()
    let tblChapters = UITableView()
    let chapterView = UIView()
    let uiButtonView = UIView()
    let lblRating = UILabel()
    let btnOpenChapterView = UIButton()
    let lblComicName = UILabel()
    let lblChapterCount = UILabel()
    let btnExitChapterView = UIButton()
    let btnReadLastChapter = UIButton()
    let btnStartReading = UIButton()
    var safeAreaInsets: UIEdgeInsets {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let mainWindow = windowScene.windows.first else {
            return .zero
        }
        return mainWindow.safeAreaInsets
    }


  
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterView.isHidden = true
        tblChapters.delegate = self
        tblChapters.dataSource = self
        tblChapters.register(ChapterTableViewCell.self, forCellReuseIdentifier: "ChapterTableViewCell")
        customComicPageScreen()
    }

    func customComicPageScreen() {
    scrollView.frame = CGRect(x: 0, y: view.frame.maxY - view.frame.height * 0.8, width: view.frame.width, height: view.frame.height * 0.8)
    scrollView.backgroundColor = .systemGray6
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(scrollView)
          
      NSLayoutConstraint.activate([
        scrollView.topAnchor.constraint(equalTo: view.topAnchor,constant: view.frame.height/5),
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      ])
       

    
    comicImageView.contentMode = .scaleAspectFit
        let url = URL(string: data!.image )
    comicImageView.kf.setImage(with: url)
    comicImageView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(comicImageView)

    NSLayoutConstraint.activate([
      comicImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      comicImageView.centerYAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50 + scrollView.frame.height/4),
      comicImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7),
      comicImageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.6)
    ])

    
    lblComicName.contentMode = .scaleAspectFit
        lblComicName.text = data!.name
    lblComicName.textColor = .black
    lblComicName.textAlignment = .center
    lblComicName.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(lblComicName)

    NSLayoutConstraint.activate([
      lblComicName.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      lblComicName.centerYAnchor.constraint(equalTo: comicImageView.centerYAnchor, constant:60 + scrollView.frame.height/4),
      lblComicName.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      lblComicName.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 0.1)
    ])
        
    lblRating.contentMode = .scaleAspectFit
        lblRating.text = "Đánh giá: \(data!.rating)"
    lblRating.textAlignment = .center
    lblRating.textColor = .black
    lblRating.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(lblRating)

    NSLayoutConstraint.activate([
      lblRating.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      lblRating.centerYAnchor.constraint(equalTo: lblComicName.centerYAnchor, constant:50),
      lblRating.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      lblRating.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 0.1)
    ])
      
      
      chapterView.contentMode = .scaleAspectFit
      chapterView.translatesAutoresizingMaskIntoConstraints = false
      chapterView.backgroundColor = .systemGray6
      scrollView.addSubview(chapterView)
      NSLayoutConstraint.activate([
        chapterView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        chapterView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
        chapterView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1),
        chapterView.widthAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1)
      ])
      
    tblChapters.contentMode = .scaleAspectFit
    tblChapters.translatesAutoresizingMaskIntoConstraints = false
    tblChapters.backgroundColor = .systemGray6
    chapterView.addSubview(tblChapters)

    NSLayoutConstraint.activate([
      tblChapters.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      tblChapters.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor,constant: scrollView.frame.height * 0.05),
      tblChapters.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.8),
      tblChapters.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9)
    ])
        
      lblChapterCount.text = "Số chương"
      lblChapterCount.textAlignment = .center
      lblChapterCount.textColor = .black
      lblChapterCount.contentMode = .scaleAspectFit
      lblChapterCount.translatesAutoresizingMaskIntoConstraints = false
      chapterView.addSubview(lblChapterCount)
      NSLayoutConstraint.activate([
            lblChapterCount.centerXAnchor.constraint(equalTo: chapterView.centerXAnchor,constant: -1*scrollView.frame.width/3.35 ),
            lblChapterCount.heightAnchor.constraint(equalTo: chapterView.heightAnchor, multiplier: 0.05),
            lblChapterCount.widthAnchor.constraint(equalTo: chapterView.widthAnchor, multiplier: 1),
            lblChapterCount.bottomAnchor.constraint(equalTo: tblChapters.topAnchor, constant: -10),
        ])
        btnExitChapterView.contentMode = .scaleAspectFit
        btnExitChapterView.translatesAutoresizingMaskIntoConstraints = false
        btnExitChapterView.backgroundColor = .systemMint
        btnExitChapterView.setTitle("X", for: .normal)
        btnExitChapterView.addTarget(self, action: #selector(btnExitChapterViewTapped), for: .touchUpInside)
        chapterView.addSubview(btnExitChapterView)
        NSLayoutConstraint.activate([
            btnExitChapterView.centerXAnchor.constraint(equalTo: chapterView.centerXAnchor,constant: scrollView.frame.width/2.5 ),
            btnExitChapterView.heightAnchor.constraint(equalTo: chapterView.widthAnchor, multiplier: 0.05),
            btnExitChapterView.widthAnchor.constraint(equalTo: chapterView.widthAnchor, multiplier: 0.05),
            btnExitChapterView.bottomAnchor.constraint(equalTo: tblChapters.topAnchor, constant: -10),
        ])
        
        uiButtonView.translatesAutoresizingMaskIntoConstraints = false
        uiButtonView.contentMode = .scaleAspectFit
        scrollView.addSubview(uiButtonView)
        NSLayoutConstraint.activate([
            uiButtonView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            uiButtonView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            uiButtonView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1),
            uiButtonView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1)
        ])
 
        btnOpenChapterView.contentMode = .scaleAspectFit
        btnOpenChapterView.translatesAutoresizingMaskIntoConstraints = false
        btnOpenChapterView.setTitle("Danh sách chương", for: .normal)
        btnOpenChapterView.backgroundColor = .systemBlue
        uiButtonView.addSubview(btnOpenChapterView)
        btnOpenChapterView.addTarget(self, action: #selector(btnOpenChapterViewTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            btnOpenChapterView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            btnOpenChapterView.topAnchor.constraint(equalTo: scrollView.centerYAnchor,constant: 270),
            btnOpenChapterView.heightAnchor.constraint(equalTo: scrollView.heightAnchor,multiplier: 0.05),
            btnOpenChapterView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,multiplier: 0.4)
        ])
        btnStartReading.contentMode = .scaleAspectFit
        btnStartReading.translatesAutoresizingMaskIntoConstraints = false
        btnStartReading.setTitle("Bắt đầu đọc", for: .normal)
        btnStartReading.backgroundColor = .systemGreen
        uiButtonView.addSubview(btnStartReading)
        NSLayoutConstraint.activate([
            btnStartReading.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor,constant: -1 * scrollView.frame.width/5),
            btnStartReading.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor,constant: 240),
            btnStartReading.heightAnchor.constraint(equalTo: scrollView.heightAnchor,multiplier: 0.05),
            btnStartReading.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.3)
        ])
        btnStartReading.addTarget(self, action: #selector(goToFirstComicContentScreen), for: .touchUpInside)

        btnReadLastChapter.contentMode = .scaleAspectFit
        btnReadLastChapter.translatesAutoresizingMaskIntoConstraints = false
        btnReadLastChapter.setTitle("Đọc mới nhất", for: .normal)
        btnReadLastChapter.backgroundColor = .systemOrange
        uiButtonView.addSubview(btnReadLastChapter)
        NSLayoutConstraint.activate([
            btnReadLastChapter.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor,constant:scrollView.frame.width/5),
            btnReadLastChapter.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor,constant: 240),
            btnReadLastChapter.heightAnchor.constraint(equalTo: scrollView.heightAnchor,multiplier: 0.05),
            btnReadLastChapter.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.3)
        ])
        btnReadLastChapter.addTarget(self, action: #selector(goToLastComicContentScreen), for: .touchUpInside)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToComicContentScreen(chapter: indexPath.row)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(data?.chapters.count ?? 0)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterTableViewCell", for: indexPath) as! ChapterTableViewCell
        cell.textLabel?.text = "Chapter \(indexPath.row + 1)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
    
    @objc func btnExitChapterViewTapped() {
        chapterView.isHidden = true
        uiButtonView.isHidden = false
    }
    
    @objc func btnOpenChapterViewTapped() {
        chapterView.isHidden = false
        uiButtonView.isHidden = true
    }
    
    @IBAction func btnReturnHomeScreen(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func goToFirstComicContentScreen() {
        goToComicContentScreen(chapter: 0)
    }
    
    @objc func goToLastComicContentScreen() {
        goToComicContentScreen(chapter: (data!.chapters.count - 1))
    }
    
    func goToComicContentScreen(chapter: Int) {
        let VCComicContent = storyboard?.instantiateViewController(withIdentifier: "VCComicContentID") as! ComicContentViewController
        VCComicContent.data = data
        VCComicContent.chapter = chapter
        VCComicContent.lblComicName.text = data!.name
        VCComicContent.lblComicChapter.text = "Chương \(chapter + 1)"
        navigationController?.pushViewController(VCComicContent, animated: true)
    }
    
}
