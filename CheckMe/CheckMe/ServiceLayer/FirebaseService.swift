//
//  FirebaseService.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 31.05.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import FirebaseAuth

protocol FirebaseServiceProtocol {
    func signIn(mail: String, password: String, completion: @escaping (String?, Error?) -> Void)
    func passwordReset(mail: String, completion: @escaping (String?, Error?) -> Void)
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
                }
                completion(nil, error)
            } else {
                completion(nil, error)
            }
        }
    }
}
