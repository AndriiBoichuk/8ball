# 8ball

8 ball - shake the phone and get a random answer.

## Flow Coordinator

### Protocol

``` bash
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
```

### Class

``` bash
class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let dbManager: DBManager

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.dbManager = DBManager()
    }

    func start() {
        // Showing MainViewController
    }
    
    func showSettings() {
        // Showing SettingsViewController
    }
}

```

## Initialize MainFlowCoordinator

### MainTabBarController

``` bash
var coordinator: MainCoordinator?

...

    private func createMainNC() -> UINavigationController {
        let navigationController = UINavigationController()
        
        coordinator = MainCoordinator(navigationController: navigationController)
        
        coordinator?.start()
        
        return navigationController
    }
```
