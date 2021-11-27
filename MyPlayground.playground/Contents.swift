import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "com.gcd.serialQueue")

print("1")
queue.async {
    print("2")
    DispatchQueue.main.sync {
        print("3")
    }
}
print("4")
queue.sync {
    print("5")
}
