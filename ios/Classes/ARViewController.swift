import Flutter
import UIKit
import ARKit
import RealityKit

class ARViewController: UIViewController {
    var arView: ARView!
    var modelName: String
    var scale: Double
    var modelEntity: ModelEntity?

    init(modelName: String, scale: Double) {
        self.modelName = modelName
        self.scale = scale
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupARView()
        loadModel()
    }

    private func setupARView() {
        arView = ARView(frame: view.bounds)
        view.addSubview(arView)

        // Enable gesture interactions
        arView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleRotation(_:))))
    }

    private func loadModel() {
        // Try to load the model as ModelEntity
        guard let loadedModel = try? ModelEntity.loadModel(named: modelName) else {
            print("❌ Failed to load model: \(modelName)")
            return
        }

        // Apply scaling and collision
        loadedModel.scale = SIMD3<Float>(Float(scale), Float(scale), Float(scale))
        loadedModel.generateCollisionShapes(recursive: true)

        // Create anchor and add model to scene
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(loadedModel)
        arView.scene.addAnchor(anchor)

        // Store the reference for gestures
        self.modelEntity = loadedModel
    }

    @objc private func handleRotation(_ gesture: UIPanGestureRecognizer) {
        guard let model = modelEntity else {
            return
        }

        let translation = gesture.translation(in: arView)
        let rotationAmount = Float(translation.x) * 0.005 // Adjust sensitivity as needed

        // Rotate model around the Y-axis
        model.transform.rotation *= simd_quatf(angle: rotationAmount, axis: [0, 1, 0])

        // Reset translation
        gesture.setTranslation(.zero, in: arView)
    }
}

/*
import Flutter
import UIKit
import ARKit
import RealityKit
// ARViewController.swift
class ARViewController: UIViewController {
    var arView: ARView!
    var modelName: String
    var scale: Double

    init(modelName: String, scale: Double) {
        self.modelName = modelName
        self.scale = scale
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupARView()
        loadModel()
    }

    private func setupARView() {
        arView = ARView(frame: view.bounds)
        view.addSubview(arView)
    }

    private func loadModel() {
        guard let modelEntity = try? ModelEntity.load(named: modelName) else {
            print("Failed to load model: \(modelName)")
            return
        }

        modelEntity.scale = SIMD3<Float>(Float(scale), Float(scale), Float(scale))

        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(modelEntity)
        arView.scene.addAnchor(anchor)
    }
}
*/