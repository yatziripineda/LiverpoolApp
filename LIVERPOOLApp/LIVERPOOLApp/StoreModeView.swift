//
//  StoreModeView.swift
//  LIVERPOOLApp
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import SwiftUI

struct StoreModeView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var sharingInProgress = true
    @State private var showToast = false

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                header
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        clickAndShareCard
                        sharedDataCard
                        reservationsCard
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 0)
            }

            // Toast overlay
            if showToast {
                toastView
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .onAppear {
            // Simula compartir datos 2s
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                sharingInProgress = false
                // muestra el toast 3s
                withAnimation { showToast = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation { showToast = false }
                }
            }
        }
    }

    // MARK: – Subviews

    private var header: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            }
            Spacer()
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
        .padding(.top, UIApplication.shared.connectedScenes
                        .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                        .first?
                        .safeAreaInsets
                        .top ?? 44)
        .padding(.bottom, 12)
        .background(Color.pinkLiverpool)
    }

    private var clickAndShareCard: some View {
        VStack(spacing: 12) {
            Image(systemName: "hanger")
                .font(.largeTitle)
                .foregroundColor(.pinkLiverpool)
            Text("Click and Share")
                .font(.title2).bold()
            Text("La app te reconoce al entrar, localiza tus artículos guardados y avisa al personal para tenerlos listos.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 8)

            Divider()

            HStack {
                Image(systemName: "hanger")
                Text("Atención en tienda")
                Spacer()
                Text("On")
                    .foregroundColor(.gray)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }

    private var sharedDataCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Datos Compartidos")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 4)

            ForEach(sharedDataRows, id: \.title) { row in
                HStack {
                    Image(systemName: row.icon)
                        .foregroundColor(.pinkLiverpool)
                    Text(row.title)
                    Spacer()
                    Text("On")
                        .foregroundColor(.gray)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 12)
                if row.title != sharedDataRows.last?.title {
                    Divider().padding(.leading, 32)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }

    private var reservationsCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Reservas")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 4)

            ForEach(reservations, id: \.id) { res in
                HStack {
                    Image(systemName: "bag")
                        .foregroundColor(.pinkLiverpool)
                    VStack(alignment: .leading) {
                        Text(res.location).bold()
                        Text("\(res.items) prendas").font(.caption).foregroundColor(.gray)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(res.date).font(.caption).foregroundColor(.gray)
                        Text(res.time).font(.caption).foregroundColor(.pinkLiverpool)
                    }
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 12)
                if res.id != reservations.last?.id {
                    Divider().padding(.leading, 32)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }

    private var toastView: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("¡Datos compartidos!")
                    .bold()
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(24)
                Spacer()
            }
            .padding(.bottom, 80)
        }
    }

    // MARK: – Data

    private var sharedDataRows: [SharedDataRow] = [
        .init(icon: "person.circle", title: "Fotografía y nombre"),
        .init(icon: "list.bullet", title: "Wishlist"),
        .init(icon: "bag", title: "5 Compras anteriores"),
        .init(icon: "ellipsis", title: "Otros")
    ]

    private var reservations: [Reservation] = [
        .init(id: 1, location: "Satelite", items: 4, date: "20/03/2025", time: "4:00 pm"),
        .init(id: 2, location: "Satelite", items: 4, date: "20/03/2025", time: "4:00 pm")
    ]
}

fileprivate struct SharedDataRow {
    let icon: String
    let title: String
}

fileprivate struct Reservation: Identifiable {
    let id: Int
    let location: String
    let items: Int
    let date: String
    let time: String
}

#Preview {
    StoreModeView()
}
