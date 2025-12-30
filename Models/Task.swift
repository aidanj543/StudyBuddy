import Foundation
import SwiftUI

enum Priority: String, CaseIterable, Codable {
    case low, medium, high
    
    var color: Color {
        switch self {
        case .low: return .green
        case .medium: return .orange
        case .high: return .red
        }
    }
}

struct Task: Identifiable, Codable {
    let id = UUID()
    var name: String
    var course: String
    var dueDate: Date
    var isDone: Bool = false
    var priority: Priority = .medium
}
