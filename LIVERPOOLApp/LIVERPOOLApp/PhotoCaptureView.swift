//
//  PhotoCaptureView.swift
//  LIVERPOOLApp
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    enum SourceType {
        case camera, photoLibrary
    }
    
    let sourceType: SourceType
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        switch sourceType {
        case .camera:
            picker.sourceType = .camera
        case .photoLibrary:
            picker.sourceType = .photoLibrary
        }
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

// MARK: – PhotoCaptureView

struct PhotoCaptureView: View {
    let onCancel: () -> Void
    let onSave:   () -> Void
    @StateObject var vm = ClienteViewModel()

    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var showCamera = true

    var body: some View {
        VStack(spacing: 16) {
            // Drag indicator
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 40, height: 5)
                .padding(.top, 8)

            // Title & subtitle
            Text("Sube tu Foto")
                .font(.title2).bold()
            Text("Sube una foto tuya y nuestro equipo te reconocerá en el momento de tu llegada.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            // Preview o placeholder
            if let img = image {
                img
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .padding(.horizontal)
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.gray, lineWidth: 2)
                    .frame(height: 400)
                    .overlay(
                        VStack(spacing: 8) {
                            Image(systemName: "camera")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                            Text("Tomar foto")
                                .foregroundColor(.gray)
                        }
                    )
                    .padding(.horizontal)
                    .onTapGesture {
                        showCamera = true
                    }
            }

            Spacer()

            // Botones
            HStack(spacing: 16) {
                Button("No compartir") {
                    onCancel()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button("Compartir") {
                  guard let uiImage = inputImage else { return }
                  vm.uploadCustomer(name: "Isaac Lopez Nuñez", image: uiImage) { success in
                    if success {
                      onSave()    // navega a StoreModeView
                    } else {
                      // muestra un error
                    }
                  }
                }
                .disabled(image == nil)
                .frame(maxWidth: .infinity)
                .padding()
                .background(image != nil ? Color.pinkLiverpool : Color.pinkLiverpool.opacity(0.5))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .onChange(of: inputImage) { _, _ in loadImage() }
        .sheet(isPresented: $showCamera) {
            ImagePicker(sourceType: .camera, image: $inputImage)
        }
    }

    private func loadImage() {
        guard let uiImage = inputImage else { return }
        image = Image(uiImage: uiImage)
    }
}
#Preview {
    PhotoCaptureView(onCancel: {
        print("cancelar")
    }, onSave: {
        print("guardar")
    })
}
