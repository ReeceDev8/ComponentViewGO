import SwiftUI
import Vision
import CoreML

struct ContentView: View {
    @EnvironmentObject var vm: ViewModel  // ViewModel is injected as EnvironmentObject
    
    @State private var exclamIsPressed: Bool = false
    @State private var predictionIsPressed: Bool = false
    @State private var helpIsPressed: Bool = false
    @State private var hueRotation: Double = 0
    
    var body: some View {
        NavigationView {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.gray, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                VStack {
                    if let image = vm.image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(minWidth: 0, maxWidth: 385, minHeight: 0, maxHeight: 300)
                            .background(Color.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.purple, .blue, .pink, .purple]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ),
                                        lineWidth: 6
                                    )
                                    .hueRotation(Angle(degrees: hueRotation)) // Animates color change
                            )
                            .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: hueRotation)
                            .onAppear {
                                hueRotation = 360 // Continuously rotates colors
                            }
                            .padding(.top, 64)
                        
                        // Display prediction text under the image
                        
                        HStack{
                            Button {
                                predictionIsPressed.toggle()
                            } label : {
                                Text(vm.predictionText)
                                    .font(.system(size: 32, weight: .bold, design: .default))
                                    .foregroundColor(.purple)
                                    .frame(alignment: .center)
                                    .padding(.bottom, 5)
                            }
                                
                            
                            VStack{
                                if let unsureButton = vm.unsureButton{
                                    Button {
                                        exclamIsPressed.toggle()
                                    } label: {
                                        Image(systemName: unsureButton)
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 25, height: 25)
                                            .popover(isPresented: $exclamIsPressed, attachmentAnchor: .point(.top), arrowEdge: .bottom) {
                                                Text("AI is unsure of results \n Please try a different image.")
                                                    .font(.system(size: 12, weight: .regular, design: .default))
                                                    .frame(width: 150, height: 50)
                                                    .foregroundColor(.red)
                                                    .presentationCompactAdaptation(.popover)
                                                    .padding(.horizontal, 2)
                                            }
                                    }
                                }
                            }
                            
                        }
                        .sheet(isPresented: $predictionIsPressed) {
                            TipsView()
                                .environmentObject(vm)
                                .presentationDetents([.medium, .large])
                                
                                
                        }
                       
                        
                        // Make the prediction after the image is loaded
                        Button(action: {
                            if let selectedImage = vm.image {
                                vm.predict(image: selectedImage)
                            }
                        }) {
                            Text("Predict")
                                .font(.headline)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .foregroundColor(.purple)
                                .clipShape(Capsule())
                        }
                    } else {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .opacity(0.6)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.horizontal)
                            .padding(.top, 64)
                    }

                    // Buttons to open the photo picker (camera or photo library)
                    HStack {
                        Button {
                            vm.source = .camera
                            vm.showPhotoPicker()
                        } label: {
                            Text("Camera")
                                .font(.headline)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .foregroundColor(.purple)
                                .clipShape(Capsule())
                        }
                        Button {
                            vm.source = .library
                            vm.showPhotoPicker()
                        } label: {
                            Text("Photos")
                                .font(.headline)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .foregroundColor(.purple)
                                .clipShape(Capsule())
                        }
                    }
                    Spacer()
                    Button {
                        helpIsPressed.toggle()
                    } label: {
                        Image(systemName: "questionmark.circle.fill")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .popover(isPresented: $helpIsPressed, attachmentAnchor: .point(.top), arrowEdge: .bottom) {
                                Text("1.) Take a photo with the camera button, or use one from your library.\n2.) Press predict, the AI will analyze your image.\n3.) Tap the component name under the image to see tips for installation.")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                                    .presentationCompactAdaptation(.popover)
                                    .frame(width: 300, height: 200)
                                    .padding(.horizontal, 2)
                            }
                    }
                }
                .sheet(isPresented: $vm.showPicker) {
                    ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                        .ignoresSafeArea()
                }
                .alert("Error", isPresented: $vm.showCameraAlert, presenting: vm.cameraError, actions:
                        { cameraError in
                    cameraError.button
                }, message: { cameraError in
                    Text(cameraError.message)
                })
            }
        }
        
    }
}
#Preview {
    ContentView()
        .environmentObject(ViewModel())
}

