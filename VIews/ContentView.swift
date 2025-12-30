import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskName = ""
    @State private var newCourse = ""
    @State private var selectedPriority: Priority = .medium
    @State private var selectedDate = Date()

    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 8) {
                    TextField("Task Name", text: $newTaskName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Course / Subject", text: $newCourse)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    HStack {
                        DatePicker("Due Date", selection: $selectedDate, displayedComponents: .date)
                        Picker("Priority", selection: $selectedPriority) {
                            ForEach(Priority.allCases, id: \.self) { priority in
                                Text(priority.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }

                    Button(action: addTask) {
                        Text("Add Task")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()

                List {
                    ForEach(viewModel.tasks.sorted(by: { $0.dueDate < $1.dueDate })) { task in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.name)
                                    .strikethrough(task.isDone)
                                    .font(.headline)
                                Text(task.course)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("Due: \(task.dueDate.formatted(.dateTime.month().day().year()))")
                                    .font(.caption)
                                    .foregroundColor(task.priority.color)
                            }
                            Spacer()
                            Button(action: { viewModel.toggleTask(task: task) }) {
                                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isDone ? .green : .gray)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
            }
            .navigationTitle("StudyBuddy")
        }
    }

    func addTask() {
        guard !newTaskName.isEmpty, !newCourse.isEmpty else { return }
        viewModel.addTask(name: newTaskName, course: newCourse, dueDate: selectedDate, priority: selectedPriority)
        newTaskName = ""
        newCourse = ""
        selectedDate = Date()
        selectedPriority = .medium
    }
}

