//
//  CreateStoryPresenter.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 25.07.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Foundation

protocol StoryViewProtocol: class {
    func setupStoryView(with category: String)
}

protocol StoryPresenterProtocol {
    init(view: StoryViewProtocol, firebaseService: FirebaseServiceProtocol, router: RouterProtocol, model: CategoryModel)
    func setupStoryView()
    func goToCategoryVC()
}

class CreateStoryPresenter: StoryPresenterProtocol {
    
    weak var view: StoryViewProtocol?
    var firebaseService: FirebaseServiceProtocol
    var router: RouterProtocol
    var model: CategoryModel

    required init(view: StoryViewProtocol, firebaseService: FirebaseServiceProtocol, router: RouterProtocol, model: CategoryModel) {
        self.view = view
        self.firebaseService = firebaseService
        self.router = router
        self.model = model
    }

    func setupStoryView() {
        view?.setupStoryView(with: model.localizedTitle)
    }

    func goToCategoryVC() {
        router.goToCategoryVC()
    }
}
