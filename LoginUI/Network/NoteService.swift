//
//  NoteService.swift
//  LoginUI
//
//  Created by Macbook on 14/08/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class NoteService{
    
    static let connection = NoteService()
    var lastDocument : QueryDocumentSnapshot?
    
    func createNote(title: String, desc: String, archive: Bool, completion: @escaping ((Error?) -> Void )) {
        let uuid = UUID().uuidString
        if let user = Auth.auth().currentUser{
            let ref = Firestore.firestore().collection("users").document(user.uid).collection("Notes").document()
            ref.setData(["id": uuid, "title": title, "desc": desc, "archive": archive, "createdAt": Timestamp(date: Date())]) { err in
                
                if err != nil {
                    print("print error")
                    return
                }
                else {
                    completion(err)
                }
            }
            
            
        }
    }
    
    
    func deleteNote(id: String){
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            let doc = db.collection("users").document(user.uid).collection("Notes").whereField("id", isEqualTo: id).getDocuments(completion: { snapshot, error in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                
                guard let docs = snapshot?.documents else { return }
                
                for doc in docs {
                    if id == doc.get("id") as! String{
                        
                        doc.reference.delete()
                        
                    }
                }})
            
        }
        
    }
    
    func updateNote(id: String, title: String, desc: String, archiveType: Bool ,completion: @escaping ((Error?)  -> Void)) {
        if let user = Auth.auth().currentUser{
            let db = Firestore.firestore()
            let doc = db.collection("users").document(user.uid).collection("Notes").whereField("id", isEqualTo: id).getDocuments(completion: { snapshot, error in
                if error != nil {
                    completion(error)
//                    print(error.localizedDescription)
                    return
                }
                guard let docs = snapshot?.documents else { return}
                for doc in docs {
                    if id == doc.get("id") as! String {
                        doc.reference.updateData(["title": title, "desc": desc, "archive": archiveType])
                    }
                }
                completion(error)
            })
        }
    }
    
    func fetchArchiveNote( completion: @escaping ([Notes])-> Void) {
            guard let user = Auth.auth().currentUser else{ return}
            let db = Firestore.firestore()
        db.collection("users").document(user.uid).collection("Notes").whereField("archive", isEqualTo: true).getDocuments(completion: { snapshot, error in
                if error != nil {
                    print("error in ")
                    return
                }
                var notes: [Notes] = []
                for doc in snapshot!.documents{
                    let id =  doc["id"] as! String
                    let title = doc["title" ] as! String
                    let desc = doc["desc"] as! String
                    let archive = doc["archive"] as! Bool
                    
                    
                    let note = Notes(id: id, title: title, desc: desc, archive: archive)
                    notes.insert(note, at: 0)
                }
                completion(notes)
            })
        }
    
    func fetchNote(completion: @escaping ([Notes]) -> Void){
        guard let user = Auth.auth().currentUser else {return}
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).collection("Notes").order(by: "createdAt").limit(to: 5).getDocuments { snapshot, error in
            if error != nil{
                print("error")
                return
            }
            var notes: [Notes] = []
            self.lastDocument = snapshot?.documents.last
            for doc in snapshot!.documents{
                guard let id = doc["id"] as? String else {return}
                guard let title = doc["title"] as? String else {return}
                guard let desc = doc["desc"] as? String else {return}
                let note = Notes(id: id, title: title, desc: desc)
                notes.insert(note, at: 0)
            }
            completion(notes)
        }
    }
    
    func fetchMoreNote(completion: @escaping ([Notes]) -> Void){
        guard let user = Auth.auth().currentUser else {return}
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).collection("Notes").order(by: "createdAt").start(afterDocument: lastDocument!).getDocuments { snapshot, error in
            if error != nil{
                print("error")
                return
            }
            var notes: [Notes] = []
            self.lastDocument = snapshot?.documents.last
            for doc in snapshot!.documents{
                guard let id = doc["id"] as? String else {return}
                guard let title = doc["title"] as? String else {return}
                guard let desc = doc["desc"] as? String else {return}
                let note = Notes(id: id, title: title, desc: desc)
                notes.insert(note, at: 0)
            }
            completion(notes)
        }
    }

}

