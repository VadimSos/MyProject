//
//  CategoryTablePresenter.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 25.07.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Foundation

protocol CategoryViewProtocol: class {
    func setupCategoryView(data: [CategoryModel])
}

protocol CategoryPresenterProtocol {
    init(view: CategoryViewProtocol, model: CategoryModel, router: RouterProtocol)
    func setupCategoryView()
    func choose(category: String)
}

class CategoryPresenter: CategoryPresenterProtocol {

    weak var view: CategoryViewProtocol?
    var model: CategoryModel
    var router: RouterProtocol
    
    required init(view: CategoryViewProtocol, model: CategoryModel, router: RouterProtocol) {
        self.view = view
        self.model = model
        self.router = router
    }

    func setupCategoryView() {
        view?.setupCategoryView(data: [.sport, .gas, .treatment, .medicine, .foot, .taxi])
    }

    func choose(category: String) {
        router.returnToCreateStoryVC(with: category)
    }
}
