import SwiftUI
import CoreData

struct HomeView: View {
    // Fetch products sorted by name
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)]
    ) var products: FetchedResults<Product>

    // Track current product index
    @State private var currentIndex = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 18) {

                // show message if no products
                if products.isEmpty {
                    Text("No products found")
                        .font(.headline)
                } else {
                    let currentProduct = products[currentIndex]
                    
                    //didplay product details
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Product ID: \(product.productID ?? "")")
                        Text("Name: \(product.productName ?? "")")
                            .font(.title2)
                            .bold()
                        Text("Description: \(product.productDescription ?? "")")
                        Text(String(format: "Price: %.2f", product.productPrice))
                        Text("Provider: \(product.productProvider ?? "")")
                    }
                    .background(Color(.systemGray6))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(12)
                    
                    // Navigation buttons
                    HStack(spacing: 20) {
                        Button("Previous") {
                            if currentIndex > 0 {
                                currentIndex -= 1
                            }
                        }
                        .disabled(currentIndex == 0)

                        Button("Next Product") {
                            if currentIndex < products.count - 1 {
                                currentIndex += 1
                            }
                        }
                        .disabled(currentIndex == products.count - 1)
                    }
                }
                
                // Links to other screens
                NavigationLink("View Full Product List", destination: ContentView())
                NavigationLink("Search Product", destination: SearchProductView())
                NavigationLink("Add Product", destination: AddProductView())
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
