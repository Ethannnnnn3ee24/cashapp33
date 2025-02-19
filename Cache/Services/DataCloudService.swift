//
//  DataCloudService.swift
//  Cache
//
//  Created by Jeffrey Santana on 4/16/18.
//  Copyright © 2018 Jefffrey Santana. All rights reserved.
//

import Foundation
import Firebase

let db = Firestore.firestore()

class DataCloudService {
	static let instance = DataCloudService()
	
	private let REF_USERS = db.collection("users")
	private let REF_TRANSFERS = db.collection("transfers")
	private var ref: DocumentReference? = nil
	private let UID = AuthService.instance.getCurrentUser().uid
	
	//MARK: - Write Documents
	
	func createUser(user: UserDetails) {
//		ref = REF_USERS.addDocument(data: [
//			"tagName": 	user.tagName,
//			"email": 	user.email,
//			"phone": 	user.phone
//		]) { err in
//			if let err = err {
//				print("Error adding document: \(err)")
//			} else {
//				print("Added document ID: \(self.ref?.documentID)")
//			}
//		}
		REF_USERS.document(UID).setData([
			"tagName": 	user.tagName,
			"email": 	user.email,
			"phone": 	user.phone
			])
	}
	
	func createTransfer(transfer: TransferDetails) {
		ref = REF_TRANSFERS.addDocument(data: [
			"amount": 		transfer.amount,
			"description": 	transfer.description,
			"sender":		transfer.senderId,
			"receiver":		transfer.receiverId,
			"timestamp":	transfer.timestamp
		]) { err in
			if let err = err {
				print("Error adding document: \(err)")
			} else {
				print("Added document ID: \(self.ref?.documentID)")
			}
		}
	}
	
	//MARK: - Read Documents
	
	func getUser(tagName: String, handler: @escaping (_ user: UserDetails) -> ()) {
		REF_USERS.whereField("tagName", isEqualTo: tagName).getDocuments { (querySnapshot, err) in
			if let err = err {
				print("Error getting user: \(err)")
			} else {
//				let doc = querySnapshot?.documents.first?.data()
//				print(doc)
//				let user = UserDetails(tagName: doc, email: <#T##String#>, phone: <#T##String#>)
				for doc in querySnapshot!.documents {
					let data = try? JSONSerialization.data(withJSONObject: doc.data())
					do {
						let user = try JSONDecoder().decode(UserDetails.self, from: data!)
						handler(user)
					} catch {
						print(error)
					}
				}
			}
		}
	}
	
	func getTransfers(handler: @escaping (_ transfers: [TransferDetails]) -> ()) {
		var allTransfers = [TransferDetails]()
		REF_TRANSFERS.whereField("sender", isEqualTo: UID).getDocuments { (querySnapshot, err) in
			if let err = err {
				print("Error getting transfers: \(err)")
			} else {
				for doc in querySnapshot!.documents {
					let transfer = TransferDetails(
						amount: doc.data()["amount"] as! Double,
						description: doc.data()["description"] as! String,
						senderId: doc.data()["sender"] as! String,
						receiverId: doc.data()["receiver"] as! String,
						timestamp: ""
					)
					allTransfers.append(transfer)
				}
			}
			handler(allTransfers)
		}
	}
}
