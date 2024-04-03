import XCTest
import Network
@testable import playerSwiftUI

class NetworkMonitorTests: XCTestCase {
    
    func testNetworkMonitor() {
        let monitor = NetworkMonitor()
        
        // Test initial state
        XCTAssertTrue(monitor.isConnected)
        
        // Simulate network status change
        let path = NWPath(status: .unsatisfied)
        monitor.monitor.pathUpdateHandler?(path)
        XCTAssertFalse(monitor.isConnected)
        
        // Simulate network status change
        let satisfiedPath = NWPath(status: .satisfied)
        monitor.monitor.pathUpdateHandler?(satisfiedPath)
        XCTAssertTrue(monitor.isConnected)
    }
}