import Foundation
import SwiftUI
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = UserDefaults.standard.loadTasks() ?? [] {
        didSet {
            UserDefaults.standard.saveTasks(tasks)
        }
    }

    func addTask(name: String, course: String, dueDate: Date, priority: Priority) {
        let task = Task(name: name, course: course, dueDate: dueDate, priority: priority)
        tasks.append(task)
    }

    func toggleTask(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isDone.toggle()
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

extension UserDefaults {
    private static let tasksKey = "student_tasks"

    func saveTasks(_ tasks: [Task]) {
        if let encoded = try? JSONEncoder().encode(tasks) {
            set(encoded, forKey: UserDefaults.tasksKey)
        }
    }

    func loadTasks() -> [Task]? {
        if let data = data(forKey: UserDefaults.tasksKey),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            return decoded
        }
        return nil
    }
}
