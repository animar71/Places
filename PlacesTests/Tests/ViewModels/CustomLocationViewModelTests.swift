//
//  CustomLocationViewModelTests.swift
//  PlacesTests
//
//  Created by Andrei Marcu on 02.11.2024.
//

import Testing
@testable import Places

struct CustomLocationViewModelTests {

    @Test("Given latitude is not filled, then error is displayed")
    func latitudeMissing() {
        let sut = CustomLocationViewModel()
        sut.longitude = "1.2"
        sut.latitude = ""
        let result = sut.tappedContinue()
        #expect(result == false)
        #expect(sut.showingAlert == true)
    }
    
    @Test("Given longitude is not filled, then error is displayed")
    func longitudeMissing() {
        let sut = CustomLocationViewModel()
        sut.latitude = "1.2"
        sut.longitude = ""
        let result = sut.tappedContinue()
        #expect(result == false)
        #expect(sut.showingAlert == true)
    }

    @Test("Given longitude and latitude is not filled, then error is displayed")
    func longitudeAndLatitudeMissing() {
        let sut = CustomLocationViewModel()
        sut.latitude = ""
        sut.longitude = ""
        let result = sut.tappedContinue()
        #expect(result == false)
        #expect(sut.showingAlert == true)
    }
    
    @Test("Given longitude and latitude are filled, then error is displayed")
    func noError() {
        let sut = CustomLocationViewModel()
        sut.latitude = "1.2"
        sut.longitude = "2.2"
        let result = sut.tappedContinue()
        #expect(result == true)
        #expect(sut.showingAlert == false)
    }
}
