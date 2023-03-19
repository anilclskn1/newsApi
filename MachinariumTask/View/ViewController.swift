//
//  ViewController.swift
//  MachinariumTask
//
//  Created by Anil Caliskan on 18.03.2023.
//

//        API KEY = 9b5a663bcc064825b59c8b2110d0fb89

import UIKit

class ViewController: UIViewController {
    
    var categoriesCollectionView: UICollectionView!
    var sourcesTableview: UITableView!
    
    
    private var sourceList: SourceViewModelList!
    private var sourceListForRefresh: SourceViewModelList!
    private var categoriesSet: Set<String>!
    private var categoriesArray: [String]!
    private var selectedCategories: Set<String>!
    private var selectedSource = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initViews()
        sourcesTableview.delegate = self
        sourcesTableview.dataSource = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        getData()
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
//    MARK: Instead of making seperate requests for each categories, we simply duplicated the newsList which is a NewsViewModel instance. The reasons why we made it that way are: Preventing a lot of api requests (Since I am using free version, it may cause 429 response from the server), We can't request multiple categories at the same time because server doesn't support it.
    
    func refreshData() {
        sourceList = sourceListForRefresh
        if selectedCategories.isEmpty{
            sourceList = sourceListForRefresh
        }else{
            let filteredSources = sourceList.sourceList.sources.filter { source in
                return selectedCategories.contains(source.category)
            }
            sourceList.sourceList.sources = filteredSources
        }
        sourcesTableview.reloadData()
    }
    
    
    
    func getData(){
        let urlForSources = "https://newsapi.org/v2/top-headlines/sources"
        let apiKey = "9b5a663bcc064825b59c8b2110d0fb89"
        
        WebService().downloadSources(url: urlForSources, apiKey: apiKey) { sources in
            self.sourceList = SourceViewModelList(sourceList: sources)
            self.sourceListForRefresh = SourceViewModelList(sourceList: sources)
            self.categoriesSet = self.sourceList.categories
            if let categories = self.categoriesSet{
                print(categories)
                self.categoriesArray = Array(self.categoriesSet)
                DispatchQueue.main.async {
                    self.categoriesCollectionView.reloadData()
                    self.sourcesTableview.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewsVC"{
            let newsVC = segue.destination as! NewsViewController
            newsVC.selectedSource = selectedSource
        }
    }
    
//  MARK: OBJECTS
    
    func initViews(){
        let parent = self.view!
        
        categoriesSet = Set<String>()
        selectedCategories = Set<String>()
        categoriesArray = [String]()
        
        
        sourcesTableview = UITableView()
        sourcesTableview.register(SourcesCustomCell.self, forCellReuseIdentifier: "customCell")
        sourcesTableview.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(sourcesTableview)
        
        
        
        let layoutForCollectionView = UICollectionViewFlowLayout()
        layoutForCollectionView.scrollDirection = .horizontal
        layoutForCollectionView.itemSize = CGSize(width: parent.frame.width / 3, height: parent.frame.height * 0.15 * 0.4)
        
        
        
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutForCollectionView)
        categoriesCollectionView.register(CategoriesCustomCell.self, forCellWithReuseIdentifier: "MyCell")
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        parent.addSubview(categoriesCollectionView)
        
        
        
        
        
        NSLayoutConstraint.activate([
            sourcesTableview.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
            sourcesTableview.topAnchor.constraint(equalTo: parent.topAnchor, constant: parent.frame.height * 0.15),
            sourcesTableview.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            sourcesTableview.rightAnchor.constraint(equalTo: parent.rightAnchor),
            sourcesTableview.leftAnchor.constraint(equalTo: parent.leftAnchor),
            
            categoriesCollectionView.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: sourcesTableview.topAnchor)
        ])
        
        
    }
    
    
}

// MARK: EXTENSIONS

extension ViewController: UITableViewDelegate{}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceList == nil ? 0 : self.sourceList.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! SourcesCustomCell
        
        let sourceViewModel = self.sourceList.sourceAtIndex(indexPath.row)
        cell.sourceTitle.text = sourceViewModel.title
        cell.sourceContent.text = sourceViewModel.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sourceViewModel = self.sourceList.sourceAtIndex(indexPath.row)
        self.selectedSource = sourceViewModel.source.id
        performSegue(withIdentifier: "toNewsVC", sender: self)
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoriesSet == nil ? 0 : categoriesSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CategoriesCustomCell
        cell.titleLabel.text = categoriesArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCustomCell else {return}
        
        if cell.containerView.backgroundColor == .white{
            cell.containerView.backgroundColor = .black
            cell.titleLabel.textColor = .white

            if let categoryName = cell.titleLabel.text{
                selectedCategories.insert(categoryName)
            }
        }
        else{
            cell.containerView.backgroundColor = .white
            cell.titleLabel.textColor = .black
            if let categoryName = cell.titleLabel.text{
                selectedCategories.remove(categoryName)
            }
        }
        refreshData()
    }
    
    
    
}

extension ViewController: UICollectionViewDelegate{}
