//
//  playerSwiftUITests.swift
//  playerSwiftUITests
//
//  Created by Alvar Arias on 2022-08-22.
//

import XCTest
@testable import playerSwiftUI
import AVFoundation

class playerSwiftUITests: XCTestCase {

    var playRadio: PlayRadio!
    
    override func setUpWithError() throws {
     playRadio = PlayRadio()
    }
    
    
    override func tearDownWithError() throws {
        playRadio = nil
    }
     
     
    func testPlaySongRadio_Success() {
           let radioURL = "https://sverigesradio.se/topsy/direkt/srapi/132.mp3"
           XCTAssertTrue(playRadio.playSongRadio(radioURL: radioURL, isPlaying: true))
           // You might want to add more assertions to test actual audio playback
       }

       func testPlaySongRadio_Failure() {
           let invalidRadioURL = "invalidURL"
           XCTAssertTrue(playRadio.playSongRadio(radioURL: invalidRadioURL, isPlaying: true))
       }

       func testPauseSongRadio() {
           let radioURL = "https://sverigesradio.se/topsy/direkt/srapi/132.mp3"
           XCTAssertTrue(playRadio.playSongRadio(radioURL: radioURL, isPlaying: true))
           XCTAssertFalse(playRadio.playSongRadio(radioURL: radioURL, isPlaying: false))
           // You might want to add assertions to verify that the player was paused
       }

    
    
}




 
