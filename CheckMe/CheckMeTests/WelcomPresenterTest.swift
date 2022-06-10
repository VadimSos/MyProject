//
//  WelcomPresenterTest.swift
//  CheckMeTests
//
//  Created by Vadim Sosnovsky on 4.06.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import XCTest
@testable import CheckMe

class MockView: WelcomViewProtocol {
    var rechabilityStatus: Bool?
    func getReachabilityConnected(status: Bool) {
        self.rechabilityStatus = status
    }
}

class WelcomPresenterTest: XCTestCase {
    
    var view: MockView!
    var presenter: WelcomPresenter!
    var router: Router!

    override func setUpWithError() throws {
        view = MockView()
        let nav = UINavigationController()
        let builder = ModuleBuilder()
        router = Router(navigationController: nav, builder: builder)
        presenter = WelcomPresenter(view: view, router: router)
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        router = nil
    }
    
    func testModuleIsNotNill() {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
        XCTAssertNotNil(router, "router is not nil")
    }
}
