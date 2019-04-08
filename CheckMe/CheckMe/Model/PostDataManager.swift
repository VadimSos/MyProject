////
////  PostDataManager.swift
////  CheckMe
////
////  Created by Vadzim Sasnouski on 4/8/19.
////  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
////
//
//import UIKit
//import Firebase
//
//class PostDataManager {
//	
//	static func displayPostsMainVC(completion: () -> ()) {
//		
//		let refDB = Database.database().reference()
//		let storage = Storage.storage().reference()
//		
//		guard let posts = Auth.auth().currentUser else {
//			return
//		}
//		
//		//download images
//		let storageRef = storage.child("posts").child("images").child(posts.uid)
//		
//		storageRef.getData(maxSize: 100 * 1024 * 1024) { (data, error) in
//			if let error = error {
//				print(error)
//			} else {
//				let image = UIImage(data: data!)
//				self.imageArray.append(image!)
//				
//				//download posts
//				refDB.child("posts").child(posts.uid).observeSingleEvent(of: .value) { (snapshot) in
//					
//					let value = snapshot.value as? [String: Any]
//					let postCategory = value?["category"] as? String ?? ""
//					let postDescription = value?["description"] as? String ?? ""
//					let postProductName = value?["productName"] as? String ?? ""
//					let postLike = value?["like"] as? Bool ?? false
//					
//					let post = PostModel(image: self.imageArray.first ?? UIImage(), name: postCategory, description: postDescription, category: postProductName, like: postLike)
//					self.postsArray.append(post)
//					
//					self.tableView.reloadData()
//				}
//			}
//		}
//		
//		/*
//		guard let appDelegate =
//		UIApplication.shared.delegate as? AppDelegate else {
//		return
//		}
//		let managedContext =
//		appDelegate.persistentContainer.viewContext
//		
//		let fetchRequest =
//		NSFetchRequest<NSManagedObject>(entityName: "Post")
//		
//		do {
//		postNameCD = try managedContext.fetch(fetchRequest) as? [Post] ?? []
//		} catch let error as NSError {
//		print("Could not fetch. \(error), \(error.userInfo)")
//		}
//		*/
//		tableView.reloadData()
//	}
//}
//
//
