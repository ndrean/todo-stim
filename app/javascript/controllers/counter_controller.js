import { Controller } from "stimulus";
import consumer from "../channels/consumer";

export default class extends Controller {
  static targets = ["count"];
  //   static values = { url: String };
  //   initialize() {
  //     this.load();
  //   }
  connect() {
    console.log("Counter controller started");
    console.log(this.countTarget);
  }
  refresh() {
    fetch("/tasks", { headers: { accept: "application/json" } })
      .then((response) => response.json())
      // the response is via Ajax from Rails endpoint "/tasks <-> tasks#index"
      // with "render json" the object {tasks_completed:  @task}
      .then((data) => {
        console.log(data);
        this.countTarget.innerText = " " + data.task_completed;
      });
  }
}
//     this.subscription = consumer.subscriptions.create(
//       {
//         channel: "TasksChannel",
//       },
//       {
//         received: this._received.bind(this),
//       }
//     );
//   }
//   _received(data) {
//     this.load();
//   }
// }
