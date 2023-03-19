//
//  NewsViewController.swift
//  MachinariumTask
//
//  Created by Anil Caliskan on 19.03.2023.
//

import UIKit
import SDWebImage

class NewsViewController: UIViewController {

    private var newsTableview: UITableView!
    private var sliderCollectionView: UICollectionView!
    private var pageControl: UIPageControl!

    
    
    var selectedSource = ""
    private var newsList: NewsViewModelList!
    var timer = Timer()
    private var sliderCounter = 0
    private var refreshNews = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("selectedid: \(selectedSource)")
        initViews()
        getData()
        newsTableview.delegate = self
        newsTableview.dataSource = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.timerSlider), userInfo: nil, repeats: true)
        }
    }
    
    func initViews(){
        let parent = self.view!
        
        pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = .gray
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        parent.addSubview(pageControl)
        
        
        
        newsTableview = UITableView()
        newsTableview.register(UINib(nibName: "NewsCustomCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        newsTableview.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(newsTableview)
        
        
        
        let layoutForCollectionView = UICollectionViewFlowLayout()
        layoutForCollectionView.scrollDirection = .horizontal
        layoutForCollectionView.itemSize = CGSize(width: parent.frame.width , height: parent.frame.height * 0.43)
        
        
        
        sliderCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutForCollectionView)
        sliderCollectionView.register(UINib(nibName: "SliderCustomCell", bundle: nil), forCellWithReuseIdentifier: "sliderCell")
        sliderCollectionView.translatesAutoresizingMaskIntoConstraints = false
        sliderCollectionView.showsHorizontalScrollIndicator = false
        sliderCollectionView.isScrollEnabled = false
        parent.addSubview(sliderCollectionView)
        
        
        NSLayoutConstraint.activate([
            newsTableview.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
            newsTableview.topAnchor.constraint(equalTo: parent.topAnchor, constant: parent.frame.height * 0.45),
            newsTableview.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            newsTableview.rightAnchor.constraint(equalTo: parent.rightAnchor),
            newsTableview.leftAnchor.constraint(equalTo: parent.leftAnchor),
            
            
            sliderCollectionView.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor),
            sliderCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sliderCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sliderCollectionView.bottomAnchor.constraint(equalTo: parent.topAnchor, constant: parent.frame.height * 0.45),
            
            
            pageControl.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: parent.topAnchor, constant: parent.frame.height * 0.42)
        ])
        
        parent.bringSubviewToFront(pageControl)
        
     
    }
    
    
    @objc func timerSlider(){
        if newsList != nil{
            if newsList.numberOfRowsInSection() >= 3{
                if sliderCounter < 3{
                    self.sliderCollectionView.scrollToItem(at: IndexPath(item: sliderCounter, section: 0), at: .right, animated: true)
                    pageControl.currentPage = sliderCounter
                    sliderCounter += 1
                }
                else{
                    sliderCounter = 0
                    self.sliderCollectionView.scrollToItem(at: IndexPath(item: sliderCounter, section: 0), at: .right, animated: false)
                    pageControl.currentPage = sliderCounter
                    sliderCounter = 1
                }
            }
        }
        refreshNews += 1
//  MARK: Instead of creating a new timer instance from Timer class, we count 12 * 5 = 60, which is 1 min.
        if refreshNews == 5{
            getData()
            refreshNews = 0
            print("renewed")
        }
    }
    
//  MARK: We use getTimeAndDate function to get the date and time seperately from publishedAt property of json. Because it is not exactly seperately
    
    func getTimeAndDate(from dateString: String) -> (date: String, time: String)? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let formattedDate = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "h:mm a"
        let formattedTime = dateFormatter.string(from: date)
        
        return (formattedDate, formattedTime)
    }

    
//  MARK: getData function is called in the viewDidLoad method and in every 1 minutes intervals
    
    func getData(){
        let urlForNews = "https://newsapi.org/v2/top-headlines"
        let apiKey = "9b5a663bcc064825b59c8b2110d0fb89"
        
        WebService().downloadNews(url: urlForNews, apiKey: apiKey, source: selectedSource) { news in
            self.newsList = NewsViewModelList(newsList: news)
            DispatchQueue.main.async {
                self.newsTableview.reloadData()
                self.sliderCollectionView.reloadData()
            }
        }
    }
    
}

// MARK: EXTENSIONS

extension NewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList == nil ? 0 : self.newsList.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCustomCell
        
        let newsViewModel = self.newsList.newAtIndex(indexPath.row)

        cell.titleLabel.text = newsViewModel.title
        cell.dateLabel.text = getTimeAndDate(from: newsViewModel.date)?.date
        cell.timeLabel.text = getTimeAndDate(from: newsViewModel.date)?.time
        cell.newsImageView.sd_setImage(with: newsViewModel.image)
        return cell
        
    }
    
}
extension NewsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * 0.4
    }
}


extension NewsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newsList == nil ? 0 : self.newsList.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCustomCell
        

        let newsViewModel = self.newsList.newAtIndex(indexPath.row)
        
        
        
        cell.titleLabel.text = newsViewModel.title
        cell.dateLabel.text = getTimeAndDate(from: newsViewModel.date)?.date
        cell.timeLabel.text = getTimeAndDate(from: newsViewModel.date)?.time
        cell.newsImageView.sd_setImage(with: newsViewModel.image)

        return cell
    }
}
    
    

extension NewsViewController: UICollectionViewDelegate{
    
}

extension NewsViewController: UICollectionViewDelegateFlowLayout{
  
}

