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
        addCloseButton()
        loadModel()
    }

    private func setupARView() {
        arView = ARView(frame: view.bounds)
        arView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(arView)

        // Enable gesture interactions
        arView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleRotation(_:))))
    }

    private func addCloseButton() {
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("✕", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        closeButton.layer.cornerRadius = 20
        closeButton.clipsToBounds = true
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeARView), for: .touchUpInside)

        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func closeARView() {
        self.dismiss(animated: true, completion: nil)
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
