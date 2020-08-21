//
//  FirestoreReferenceManager.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/12/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import FirebaseFirestore


struct FirestoreReferenceManager {
//    static let enviroment = "Provider"
    static let db = Firestore.firestore()
    static let root = db.collection("users")
    
//    static func referenveForUserPublicData(uid: String) -> DocumentReference {
//        return root
//            .collection(FirebaseKeys.CollectionPath.users).document(uid)
//            .collection(FirebaseKeys.CollectionPath.publicData)
//            .document(FirebaseKeys.CollectionPath.publicData)
//    }
    
}
