import UIKit

class TaskListViewController: UITableViewController {

    var tasks: [Task] = [
        Task(title: "Your favorite hiking spot", description: "Where do you go to be one with nature?"),
        Task(title: "Best coffee shop", description: "Find the best coffee in town!"),
        Task(title: "A cool street mural", description: "Find and capture street art."),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Scavenger Hunt"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.accessoryType = task.isCompleted ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskDetailVC = TaskDetailViewController(task: tasks[indexPath.row])
        navigationController?.pushViewController(taskDetailVC, animated: true)
    }
}

