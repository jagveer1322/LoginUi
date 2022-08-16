//
//  HomeController.swift
//  LoginUI
//
//  Created by Macbook on 06/08/22.
//
import UIKit

class HomeController : UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var note : [Notes] = []
    var isListView = false
    var toggleButton : UIBarButtonItem!
    var addButton : UIBarButtonItem!
    var delegate: HomeControllerDelegate?
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.frame = view.bounds
        configureNavigationBar()
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
        navigationItem.title = "Apple Keep"
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
        cell.configure(titleLabel: note[indexPath.row].title!, descLabel: note[indexPath.row].desc!)
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
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("tapped on cell")

                 let selectNote = note[indexPath.row]
                let noteDetail = NoteDetailViewController()
                noteDetail.selectNote = selectNote
//                let editVC = NoteDetailViewController()
//
//                let selectedNote: Notes!
//                selectedNote = note[indexPath.row]
//                editVC.selectNote = selectedNote
                self.navigationController?.pushViewController(noteDetail, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNotes()
    }
    
    func getNotes(){
        NoteService.connection.fetchNote { notes in
            self.note = notes
            self.collectionView.reloadData()
        }
    }
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
