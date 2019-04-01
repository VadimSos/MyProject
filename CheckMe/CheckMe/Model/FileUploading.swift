////
////  File.swift
////  CheckMe
////
////  Created by Vadzim Sasnouski on 3/31/19.
////  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
////
//
//import Foundation
//import Firebase
//
//class FirFile: NSObject {
//	
//	/// Singleton instance
//	static let shared: FirFile = FirFile()
//	
//	/// Path
//	let kFirFileStorageRef = Storage.storage().reference().child("Files")
//	
//	/// Current uploading task
//	var currentUploadTask: StorageUploadTask?
//	
//	func upload(data: Data,
//				withName fileName: String,
//				block: @escaping (_ url: String?) -> Void) {
//		
//		// Create a reference to the file you want to upload
//		let fileRef = kFirFileStorageRef.child(fileName)
//		
//		/// Start uploading
//		upload(data: data, withName: fileName, atPath: fileRef) { (url) in
//			block(url)
//		}
//	}
//	
//	func upload(data: Data,
//				withName fileName: String,
//				atPath path:StorageReference,
//				block: @escaping (_ url: String?) -> Void) {
//		
//		// Upload the file to the path
//		self.currentUploadTask = path.putData(data, metadata: nil) { (metaData, error) in
//			let url = metaData?.downloadURL()?.absoluteString
//			block(url)
//		}
//	}
//	
//	func cancel() {
//		self.currentUploadTask?.cancel()
//	}
//}
