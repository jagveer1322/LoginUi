//
//  HomeController.swift
//  LoginUI
//
//  Created by Macbook on 06/08/22.
//
import UIKit

class HomeController : UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource {
    var note : [Notes] = []
    var delegate: HomeControllerDelegate?
    var collectionView : UICollectionView!
//    let label = UILabel()
//    let button = UIButton()
    
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
//    func configureLabel(){
//        view.addSubview(label)
//        label.backgroundColor = .white
//        label.text = "empty notes"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            label.heightAnchor.constraint(equalToConstant: 30),
//            label.widthAnchor.constraint(equalToConstant: 120),
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
    func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.title = "Apple Keep"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu-3"), style: .plain, target: self, action: #selector(handleMenuToggle))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNotes))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return note.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.configure(titleLabel: note[indexPath.row].title!, descLabel: note[indexPath.row].desc!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: (width - 15)/2, height: (width - 15)/2)
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    

}
