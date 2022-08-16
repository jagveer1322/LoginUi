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
    
    func createNote(title: String, describe: String){
        
        if let user = Auth.auth().currentUser {
            
            let db = Firestore.firestore()
            let doc = db.collection("users").document(user.uid).collection("Notes").document()
            
            doc.setData(["id": doc.documentID, "title": title, "desc": describe, "createdAt": Timestamp(date: Date())]) { err in
                
                if err != nil {
                    print("print error")
                    return
                }
            }
        }
    }
    
    func fetchNote(completion: @escaping ([Notes]) -> Void){
        guard let user = Auth.auth().currentUser else {return}
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).collection("Notes").order(by: "id").getDocuments { snapshot, error in
            if error != nil{
                print("error")
                return
            }
            var notes: [Notes] = []
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
    func deleteNote(id: String){
           if let user = Auth.auth().currentUser {
               let db = Firestore.firestore()
               let doc =  db.collection("users").document(user.uid).collection("Notes").document(id)
               doc.delete()
           
       }
           
       }
}

