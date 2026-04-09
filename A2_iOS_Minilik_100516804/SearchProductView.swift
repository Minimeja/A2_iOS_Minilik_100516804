import SwiftUI
import CoreData

struct SearchProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)]
    ) var products: FetchedResults<Product>

    @State private var searchText = ""

    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return Array(products)
        } else {
            return products.filter {
                ($0.productName?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                ($0.productDescription?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search product by name or description", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List {
                    ForEach(filteredProducts) { product in
                        VStack(alignment: .leading) {
                            Text(product.productName ?? "")
                                .font(.headline)
                            Text(product.productDescription ?? "")
                                .font(.subheadline)
                            Text(String(format: "Price: %.2f", product.productPrice))
                        }
                    }
                }
            }
            .navigationTitle("Search Product")
        }
    }
}
