//
//  BeeFreeTests.swift
//  BeeFreeTests
//
//  Created by Mike Wang on 2/23/24.
//

import XCTest

@testable import BeeFree

class AuthenticationTests: XCTestCase {
    var authServiceMock: FirebaseAuthServiceMock!
    var viewModel: AuthenticationViewModel!

    override func setUp() {
        super.setUp()
        authServiceMock = FirebaseAuthServiceMock()
        viewModel = AuthenticationViewModel(authService: authServiceMock)
    }

    func testLoginNewUser() {
        authServiceMock.isUserNew = true
        viewModel.loginWithGoogle { result in
            switch result {
            case .success(let user):
                XCTAssertTrue(user.isNewUser)
                XCTAssertEqual(user.email, "newuser@example.com")
            case .failure(let error):
                XCTFail("Login failed: \(error.localizedDescription)")
            }
        }
    }

    func testLoginExistingUser() {
        authServiceMock.isUserNew = false
        viewModel.loginWithGoogle { result in
            switch result {
            case .success(let user):
                XCTAssertFalse(user.isNewUser)
                XCTAssertEqual(user.email, "existinguser@example.com")
            case .failure(let error):
                XCTFail("Login failed: \(error.localizedDescription)")
            }
        }
    }
}
