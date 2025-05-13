//
//  HomeView.swift
//  LIVERPOOLApp
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//


import SwiftUI

struct HomeView: View {
    @State private var showNearLiverpool   = false
    @State private var showPhotoCapture    = false
    @State private var navigateToStoreMode = false


    // Segmented Control
    @State private var selectedSegment = 1
    
    // Categorías
    @State private var selectedCategory = "Hogar"
    let categories = ["Hogar", "Electrónica", "Videojuegos", "Zapatos", "Belleza"]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        header
                        segmentedControl
                            .padding(.top, 20) // para solaparse con el header
                        greeting
                            .padding(.horizontal)
                            .padding(.top, 16)
                        featureCards
                            .padding(.horizontal)
                            .padding(.top, 8)
                        categoryTabs
                            .padding(.top, 24)
                            .padding(.horizontal)
                        productCarousel
                            .padding(.top, 8)
                            .padding(.horizontal)
                        
                        Spacer(minLength: 100) // da espacio para la tab bar
                    }
                }
                
                tabBar
                
                NavigationLink(
                    destination: StoreModeView()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true),
                    isActive: $navigateToStoreMode
                ) {
                    EmptyView()
                }

            }
            .onAppear {
                // dispara el primer modal tras 5s
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showNearLiverpool = true
                }
            }
            // 1️⃣ Modal “Cerca de Liverpool”
            .sheet(isPresented: $showNearLiverpool) {
                NotificationPermissionView(
                    onDecline: {
                        showNearLiverpool = false
                    },
                    onAccept: {
                        showNearLiverpool = false
                        showPhotoCapture = true
                    }
                )
                .presentationDetents([.height(500)])
            }
            // 2️⃣ Modal “Tomar foto”
            .sheet(isPresented: $showPhotoCapture) {
                PhotoCaptureView(
                    onCancel: {
                        showPhotoCapture = false
                    },
                    onSave: {
                        showPhotoCapture = false
                        // en vez de sheet, activamos el NavigationLink
                        navigateToStoreMode = true
                    }
                )
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top)

        }
        
    }
    
    // MARK: – Subviews
    
    private var header: some View {
        ZStack(alignment: .bottom) {
            Color.pinkLiverpool
            VStack(spacing: 16) {
                HStack {
                    Label("Tienda más cerca", systemImage: "location.fill")
                        .foregroundColor(.white)
                    Spacer()
                    HStack(spacing: 16) {
                        Image(systemName: "heart")
                            .foregroundColor(.white)
                        Image(systemName: "bag")
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 44)

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    Text("Buscar por productos y más")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(8)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
                
                Spacer().frame(height: 32)
            }
        }
        .frame(height: 180)
    }
    
    private var segmentedControl: some View {
        Picker("", selection: $selectedSegment) {
            Text("Lo nuevo").tag(0)
            Text("Para ti").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .onAppear(perform: {
            UISegmentedControl.appearance().selectedSegmentTintColor = .pinkLiverpool
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.pinkLiverpool], for: .normal)
            
        })
        .padding(.horizontal)
    }
    
    private var greeting: some View {
        HStack {
            Text("Hola Gustavo 👋")
                .font(.title3)
                .bold()
            Spacer()
        }
    }
    
    private var featureCards: some View {
        HStack(spacing: 16) {
            FeatureCardView(title: "Asistente de compras", iconName: "assistantIcon")
            FeatureCardView(title: "Modo tienda", iconName: "storeModeIcon") {
                navigateToStoreMode = true
            }
        }
    }
    
    private var categoryTabs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(categories, id: \.self) { cat in
                    VStack(spacing: 4) {
                        Text(cat)
                            .foregroundColor(selectedCategory == cat ? .pinkLiverpool : .gray)
                            .onTapGesture { selectedCategory = cat }
                        if selectedCategory == cat {
                            Capsule()
                                .frame(height: 2)
                                .foregroundColor(.pinkLiverpool)
                        } else {
                            Capsule()
                                .frame(height: 2)
                                .foregroundColor(.clear)
                        }
                    }
                }
            }
        }
    }
    
    private var productCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ProductCardView(
                    name: "Set de almohada Tesso Home",
                    imageName: "cushionImage",
                    price: "$649.00",
                    oldPrice: "$739.00"
                )
                // puedes repetir para más productos
            }
        }
    }
    
    private var tabBar: some View {
        HStack {
            TabBarItem(icon: "house.fill", title: "Inicio", isSelected: true)
            Spacer()
            TabBarItem(icon: "magnifyingglass", title: "Explorar")
            Spacer()
            TabBarItem(icon: "bag", title: "Tienda")
            Spacer()
            TabBarItem(icon: "square.grid.2x2", title: "Servicios")
            Spacer()
            TabBarItem(icon: "person", title: "Mi cuenta")
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        .background(Color.white.shadow(radius: 4))
    }
}

#Preview {
    HomeView()
}
