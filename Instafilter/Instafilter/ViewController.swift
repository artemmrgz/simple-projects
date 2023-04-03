//
//  ViewController.swift
//  Instafilter
//
//  Created by Artem Marhaza on 29/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let customView = UIView()
    let imageView = UIImageView()
    let intensityLabel = UILabel()
    let slider = UISlider()
    let changeButton = UIButton()
    let saveButton = UIButton()
    
    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        layout()
        
        title = "Instafilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }
    
    private func setup() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .darkGray
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        intensityLabel.translatesAutoresizingMaskIntoConstraints = false
        intensityLabel.textAlignment = .center
        intensityLabel.text = "Intensity:"
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(intensityChanged), for: .valueChanged)
        
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.setTitle("Change Filter", for: .normal)
        changeButton.setTitleColor(.systemBlue, for: .normal)
        changeButton.addTarget(self, action: #selector(changeTapped), for: .touchUpInside)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    private func layout() {
        customView.addSubview(imageView)
        view.addSubview(customView)
        view.addSubview(intensityLabel)
        view.addSubview(slider)
        view.addSubview(changeButton)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            customView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            customView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            imageView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10),
            imageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10),
            
            intensityLabel.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 20),
            intensityLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            
            slider.topAnchor.constraint(equalTo: intensityLabel.topAnchor),
            slider.leadingAnchor.constraint(equalTo: intensityLabel.trailingAnchor, constant: 10),
            slider.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            
            changeButton.topAnchor.constraint(equalTo: intensityLabel.bottomAnchor, constant: 20),
            changeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            changeButton.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            changeButton.widthAnchor.constraint(equalToConstant: 120),
            changeButton.heightAnchor.constraint(equalToConstant: 44),
            
            saveButton.topAnchor.constraint(equalTo: changeButton.topAnchor),
            saveButton.bottomAnchor.constraint(equalTo: changeButton.bottomAnchor),
            saveButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            saveButton.widthAnchor.constraint(equalTo: changeButton.widthAnchor),
            saveButton.heightAnchor.constraint(equalTo: changeButton.heightAnchor)
        ])
    }
    
    private func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(slider.value, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(slider.value * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(slider.value * 10, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }

        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            imageView.image = processedImage
        }
    }
    
    private func setFilter(action: UIAlertAction) {
        guard currentImage != nil else { return }
        guard let actionTitle = action.title else { return }
        
        currentFilter = CIFilter(name: actionTitle)
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
}


// MARK: Actions
extension ViewController {
    @objc func addTapped() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func changeTapped(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        let filters = ["CIBumpDistortion", "CIGaussianBlur", "CIPixellate", "CISepiaTone", "CITwirlDistortion", "CIUnsharpMask", "CIVignette"]
        
        for filter in filters {
            ac.addAction(UIAlertAction(title: filter, style: .default, handler: setFilter))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender
        }
        present(ac, animated: true)
    }
    
    @objc func saveTapped() {
        guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func intensityChanged() {
        applyProcessing()
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        var ac: UIAlertController!
        
        if let error = error {
            ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
        } else {
            ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos", preferredStyle: .alert)
        }
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

// MARK: Image Picker Delegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        imageView.image = currentImage
        imageView.alpha = 0
        UIView.animate(withDuration: 1, delay: 0) {
            self.imageView.alpha = 1
        }
    }
}
