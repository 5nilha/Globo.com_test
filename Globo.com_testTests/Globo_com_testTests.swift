//
//  Globo_com_testTests.swift
//  Globo.com_testTests
//
//  Created by Fabio Quintanilha on 12/8/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import XCTest
@testable import Globo_com_test
class Globo_com_testTests: XCTestCase {
    
    private var testUser: UserViewModel!
    private var filme: FilmeViewModel!
    private var testFilme: FilmeViewModel!
    
    private var testFilmeData : [String : Any] {
        return ["cover_image": "https://assets.voxcinemas.com/posters/P_HO00006396.jpg",
                "title": "Amigos Para Sempre",
                "subtitle": "Inglês",
                "duration": "2h 05m",
                "synopsis": "Um dos maiores sucessos de todos os tempos do cinema francês, Intocáveis, lançado em 2012, ganha aqui seu inevitável remake hollywoodiano. Bryan Cranston, o eterno Walter White de Breaking Bad, assume o papel do milionário tetraplégico que contrata um homem negro com um passado problemático para ser seu assistente e ajudá-lo nas tarefas do dia a dia – o personagem é vivido pelo comediante Kevin Hart. Os dois homens têm dificuldade para se aproximar, mas acabam desenvolvendo uma forte amizade.",
                "reviews": 4,
                "movie_category": "Comédia e Drama",
                "released_at": 1547186400]
    }
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        AuthVM.auth.signOut()
    }
    
    func textUserRegistration() {
        let user = AuthVM.auth.signUpUser(firstName: "test@test.com", lastName: "passW0rd", email: "Test", password: "Test")
        XCTAssertNotNil(user)
    }
    
    func testUserAuthorization() {
        let user = AuthVM.auth.signInUser(email: "test@test.com", password: "passW0rd")
        XCTAssertNotNil(user)
        self.testUser = user
    }
    
    func deletingUser() {
//        Auth.deleteAuthentication(for: self.testUser.id)
    }
    
    func testFilmeObject() {
        testFilme = FilmeViewModel(filmeJSON: testFilmeData)
        XCTAssert(testFilme != nil)
    }
    
    func testJsonParse() {
        Webservices.fetchFilmes { (filmes) in
            XCTAssert(filmes != nil)
            if filmes!.count > 0 {
                self.filme = filmes?.first
            }
        }
     }
}
