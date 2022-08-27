//
//  ArchiveViewController.swift
//  LoginUI
//
//  Created by Macbook on 24/08/22.
//

import UIKit

class ArchiveViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var note: [Notes] = []
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        configureNav()
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
               collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    
        collectionView.frame = view.bounds
        NoteService.connection.fetchArchiveNote { notes in
        self.note = notes
        self.collectionView.reloadData()
        }
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
               
        cell.configure(titleLabel: note[indexPath.row].title!, descLabel: note[indexPath.row].desc!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return note.count
    }
    func configureNav(){
           view.backgroundColor = .white
           
           navigationController?.navigationBar.backgroundColor = .cyan
           navigationItem.title = "Archive"
           navigationController?.navigationBar.barStyle = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(handleDismiss))
   }

       @objc func handleDismiss(){
           self.navigationController?.popViewController(animated: true)
       }

}
extension ArchiveViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
      return CGSize(width: (width - 15)/2, height: (width - 15)/2)
    }
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
