import UIKit
import AnalyticsKit
class ViewController: UIViewController {
    private var countIndex: [Int] { [1, 10, 20, 30, 50] }
    private lazy var eventCountSegment: UISegmentedControl = {
        let items = countIndex.map { "\($0)" }
        let segment = UISegmentedControl(items: items)
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    private let generateNormalEventsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Generate Normal Events", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let generateHighPriorityEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Generate High Priority Event", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let flushButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Manual Flush", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add controls
        [eventCountSegment, generateNormalEventsButton, generateHighPriorityEventButton, flushButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Segment constraints
            eventCountSegment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eventCountSegment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            eventCountSegment.widthAnchor.constraint(equalToConstant: 250),
            
            // Normal event button constraints
            generateNormalEventsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generateNormalEventsButton.topAnchor.constraint(equalTo: eventCountSegment.bottomAnchor, constant: 30),
            generateNormalEventsButton.widthAnchor.constraint(equalToConstant: 200),
            generateNormalEventsButton.heightAnchor.constraint(equalToConstant: 44),
            
            // High priority event button constraints
            generateHighPriorityEventButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generateHighPriorityEventButton.topAnchor.constraint(equalTo: generateNormalEventsButton.bottomAnchor, constant: 20),
            generateHighPriorityEventButton.widthAnchor.constraint(equalToConstant: 200),
            generateHighPriorityEventButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Add flush button constraints
            flushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flushButton.topAnchor.constraint(equalTo: generateHighPriorityEventButton.bottomAnchor, constant: 20),
            flushButton.widthAnchor.constraint(equalToConstant: 200),
            flushButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupActions() {
        generateNormalEventsButton.addTarget(self, action: #selector(generateNormalEvents), for: .touchUpInside)
        generateHighPriorityEventButton.addTarget(self, action: #selector(generateHighPriorityEvent), for: .touchUpInside)
        flushButton.addTarget(self, action: #selector(manualFlush), for: .touchUpInside)
    }
    
    @objc private func generateNormalEvents() {
        let counts = countIndex
        let selectedCount = counts[eventCountSegment.selectedSegmentIndex]
        
        // Generate specified number of normal events (priority 0)
        for _ in 0..<selectedCount {
            logRandomEvent(priority: 0)
        }
    }
    
    @objc private func generateHighPriorityEvent() {
        // Generate one high priority event (priority 1)
        logRandomEvent(priority: 1)
    }
    
    @objc private func manualFlush() {
        Analytics.flush()
    }
    
    var index = 0
    private func logRandomEvent(priority: Int) {
        let eventName = "test_event_\(index)"
        // generate random string function
        func randomString(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            return String((0..<length).map{ _ in letters.randomElement()! })
        }
        
        let randomParams = [
            "param1": randomString(length: 5),
            "param2": randomString(length: 3)
        ]
        Analytics.log(eventName: eventName, eventParams: randomParams, priority: priority)
        index += 1
    }
}
