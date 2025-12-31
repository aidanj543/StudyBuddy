# StudyBuddy
#### Video Demo: https://youtu.be/jHEH4ruv9Hc?si=NvkYJ1V2-6OlPMl4
#### Description:
StudyBuddy is an IOS SwiftUI app designed to help college students manage their tasks and study schedule.
Students can add tasks for different courses, set priorities, and track due dates.

---
## Overview
StudyBuddy is structured using the **Model-View-ViewModel (MVVM)** design pattern. This helps ensure that data, logic, and interface components are modular and maintainable.
Students can easily add new tasks, delete them, or even toggle their completion status. Tasks are sorted by priority, which allows for immediate acknowledgement.
The main files in this project include `StudyBuddyApp.swift`, `Models/Task.swift`, `ViewModels/TaskViewModel.swift`, and `Views/ContentView.swift`.
Each file plays an important role towards the functionality of StudyBuddy.

--

## StudyBuddyApp.swift

This file serves as the entry point of StudyBuddy. SwiftUI requires a `@main` structure to indicate the starting point of the app
Inside the structure, a `WindowGroup` is declared, which contains the initial view presented to the User.

--

## Models/Task.swift

`Task.swift` defines the **data model** for the application. The `Task` struct includes properties such as `name`, `course`, `dueDate`, `priority`, and `isDone`. Each task is also assigned a unique `UUID` to conform to the `Identifiable` protocol, which is essential for efficient rendering in SwiftUI lists. Additionally, the struct conforms to `Codable`, allowing tasks to be easily serialized and stored in `UserDefaults`.

The `Priority` enum categorizes tasks into `low`, `medium`, and `high` priorities. This choice was intentional to provide a clear visual hierarchy in the interface, helping students quickly identify which tasks require immediate attention. Using an enum ensures that only valid priorities are assigned, reducing potential bugs and maintaining data integrity.

---

## ViewModels/TaskViewModel.swift

The **ViewModel** is where the business logic resides. `TaskViewModel` conforms to `ObservableObject` and uses `@Published` to automatically notify the UI whenever the `tasks` array changes. Functions in this file include `addTask`, `deleteTask`, and `toggleTask`, allowing for manipulation of the task list.

A key design decision was to handle **data persistence within the ViewModel**. By extending `UserDefaults` with helper functions for saving and loading tasks, the app ensures that all tasks are maintained across app sessions. This approach avoids adding unnecessary complexity while still delivering a robust feature that enhances user experience.

Separating the ViewModel from the View allows for easier testing, as the logic can be examined independently of the user interface. This separation also aligns with MVVM principles, improving code readability and maintainability.

---

## Views/ContentView.swift

`ContentView.swift` contains the **main user interface**. Users can enter task details through text fields for the task name and course, select a due date using a `DatePicker`, and choose a priority with a `Picker`. Tasks are displayed in a list sorted by due date, where each item shows its name, course, due date, and a visual indicator of priority. Users can toggle completion status by tapping a checkmark and delete tasks via swipe gestures.

The choice to use SwiftUI for the UI was intentional due to its declarative syntax, which allows the interface to automatically update in response to changes in the underlying data model. This results in less boilerplate code compared to UIKit, making the project more maintainable and readable. Additionally, using a single `ContentView` for all primary functionality simplifies navigation and reduces the cognitive overhead for the user.
