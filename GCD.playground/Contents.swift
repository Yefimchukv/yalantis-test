import UIKit

func bringCancellationOfWorkItem() {
    let backgroundQueue = DispatchQueue.global(qos: .background)
    
    var task: DispatchWorkItem?
    
    task = DispatchWorkItem {
        while true {
            guard let item = task, !item.isCancelled else {
                break
            }
            print("0")
        }
    }
    
    task?.notify(queue: .main) { print("completed") }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
        task?.cancel()
    }
    
    backgroundQueue.async(execute: task!)
}

bringCancellationOfWorkItem()

func bringDeadlock() {
    print("before deadlock")
    DispatchQueue.main.sync {
        print("Line1")
    }
    print("Line2")
}

//bringDeadlock()

func resolveDeadlock() {
    let queue = DispatchQueue(label: "com.GCD.yefimchukv.serial.1")
    print("before lines print")
    queue.sync {
        print("Line1")
    }
    print("Line2")
}

//resolveDeadlock()
