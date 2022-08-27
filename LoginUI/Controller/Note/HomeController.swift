//
//  HomeController.swift
//  LoginUI
//
//  Created by Macbook on 06/08/22.
//
import UIKit

class HomeController : UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UISearchControllerDelegate {
    
    var note : [Notes] = []
    
    var isListView = false
    var toggleButton : UIBarButtonItem!
    var addButton : UIBarButtonItem!
    let searchController = UISearchController(searchResultsController: nil)
    var delegate: HomeControllerDelegate?
    var collectionView : UICollectionView!
//    var limit = 5
//    var totalNotes = 0
//    var index = 0
//    var displayNotes:[Notes] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
       
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        configureNavigationBar()
        searchBarSetup()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNotes()
        
    }
    
    func getNotes(){
        NoteService.connection.fetchNote { notes in
        self.note = notes
           print("====\(self.note.count)")
//            self.totalNotes = self.note.count
//            print("-------\(self.totalNotes)")
//            while self.index < self.limit
//            {
//                print(" inside while")
//                self.displayNotes.append(self.note[self.index])
//                self.index = self.index + 1
//            }
        self.collectionView.reloadData()    
        }
    }
    
    func searchBarSetup(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    @objc func addNotes(){
        let notevc = NoteDetailViewController()
        navigationController.self?.pushViewController(notevc, animated: true)
    }
    
    @objc func viewSwitch(){
        
        if isListView{
            toggleButton = UIBarButtonItem(image: UIImage(named: "grid (1)"), style: .plain, target: self, action: #selector(viewSwitch))
            isListView = false
        }
        else{
            toggleButton = UIBarButtonItem(image: UIImage(named: "grid"), style: .plain, target: self, action: #selector(viewSwitch))
            isListView = true
        }
        navigationItem.rightBarButtonItems = [addButton,toggleButton]
        self.collectionView?.reloadData()
        
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.title = "Keep Notes"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu (2)"), style: .plain, target: self, action: #selector(handleMenuToggle))
        addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNotes))
        toggleButton = UIBarButtonItem(image: UIImage(named: "grid"), style: .plain, target: self, action: #selector(viewSwitch))
        navigationItem.rightBarButtonItems = [addButton,toggleButton]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return note.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
//        cell.configure(titleLabel: note[indexPath.row].title!, descLabel: note[indexPath.row].desc!)
        cell.titlelabel.text = note[indexPath.row].title
        cell.desc.text = note[indexPath.row].desc
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        if isListView {
            return CGSize(width: width, height: 120)
        }else {
            return CGSize(width: (width - 15)/2, height: (width - 15)/2)
        }
        
    }
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tap on cell")
        let vc = NoteDetailViewController()
        vc.selectNote = note[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("will display" )
//        if indexPath.row == displayNotes.count - 1
//        {
//            print("enter in if")
//            var index = displayNotes.count  - 1
//            if index + 5 > displayNotes.count - 1
//            {
//                limit = note.count - index
//            }
//            else
//            {
//                limit = index + 10
//            }
//            while index < limit
//            {
//                displayNotes.append(note[index])
//                index = index + 1
//             }
//            self.perform(#selector(loadCollectionView), with: nil, afterDelay: 2)
//        }
//    }
//    @objc func loadCollectionView() {
//        self.collectionView.reloadData()
//        print("load collection view")
//    }
  
}

extension HomeController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}
extension HomeController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else{ return }
        if searchText == ""{
            print("empty search")
            print(note)
            NoteService.connection.fetchNote { note in
            self.note = note
            self.collectionView?.reloadData()
            }
        }
        else{
            print("searching")
            note = note.filter{( $0.title?.contains(searchText))!}
            self.collectionView?.reloadData()
        }
    }
    
}
