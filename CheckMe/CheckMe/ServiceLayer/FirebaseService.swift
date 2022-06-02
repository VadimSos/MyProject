//
//  FirebaseService.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 31.05.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Firebase
import FirebaseAuth

protocol FirebaseServiceProtocol {
    func signIn(mail: String, password: String, completion: @escaping (String?, Error?) -> Void)
    func passwordReset(mail: String, completion: @escaping (String?, Error?) -> Void)
    func create(user: RegisterModel, completion: @escaping (String?, Error?) -> Void)
}

class FirebaseService: FirebaseServiceProtocol {
    func signIn(mail: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: mail, password: password) { _, error in
            if let error = error {
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    completion(errorCode.errorMessages, error)
                } else {
                    completion(nil, error)                    
                }
            } else {
                completion(nil, error)
            }
        }
    }

    func passwordReset(mail: String, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: mail) { error in
            if let error = error {
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    completion(errorCode.errorMessages, error)
                } else {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
    }

    func create(user: RegisterModel, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: user.mail ?? "", password: user.password ?? "") { _, error in
            if let error = error {
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    completion(errorCode.errorMessages, error)
                } else {
                    self.setUserData(user: user)
                    completion(nil, error)
                }
            } else {
                self.setUserData(user: user)
                completion(nil, error)
            }
        }
    }

    private func setUserData(user: RegisterModel) {
        let ref = Database.database().reference()

        guard let userUID = Auth.auth().currentUser?.uid else { return }
        let firebaseUser = ref.child("users").child(userUID)

        firebaseUser.child("name").setValue(user.name)
        firebaseUser.child("familyName").setValue(user.familyName)
        firebaseUser.child("cellPhoneNumber").setValue(user.phoneNumberFirst)
        firebaseUser.child("phoneNumber").setValue(user.phoneNumberSecond)
    }
}
