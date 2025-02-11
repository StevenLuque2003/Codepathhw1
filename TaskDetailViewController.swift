import UIKit
import MapKit
import PhotosUI

class TaskDetailViewController: UIViewController, PHPickerViewControllerDelegate {
    
    var task: Task
    let imageView = UIImageView()
    let mapView = MKMapView()
    let attachButton = UIButton(type: .system)

    init(task: Task) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = task.title
        view.backgroundColor = .white

        setupUI()
    }

    func setupUI() {
        // ImageView
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false

        // MapView
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isHidden = true  // Hide until a location is available

        // Attach Button
        attachButton.setTitle("Attach Photo", for: .normal)
        attachButton.addTarget(self, action: #selector(openPhotoPicker), for: .touchUpInside)
        attachButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(mapView)
        view.addSubview(attachButton)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            mapView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 300),

            attachButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20),
            attachButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func openPhotoPicker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else { return }

        provider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
            guard let self = self, let selectedImage = image as? UIImage else { return }
            DispatchQueue.main.async {
                self.imageView.image = selectedImage
                self.task.image = selectedImage
                self.task.isCompleted = true
            }
        }
    }
}

