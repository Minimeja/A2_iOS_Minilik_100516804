import SwiftUI
import CoreData

struct ContentView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)]
    ) var products: FetchedResults<Product>

    @State private var showAddProduct = false

    var body: some View {
        NavigationView {
            List {
                ForEach(products) { product in
                    VStack(alignment: .leading, spacing: 5) {

                        Text(product.productName ?? "")
                            .font(.headline)

                        Text(product.productDescription ?? "")
                            .font(.subheadline)

                        Text(String(format: "Price: %.2f", product.productPrice))
                            .font(.caption)
                    }
                    .padding(.vertical, 5)
                }
                .onDelete(perform: deleteProducts)
            }
            .navigationTitle("Products")

            .toolbar {

                // LEFT: Edit 
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }

                // RIGHT: Add + Search 
                ToolbarItemGroup(placement: .navigationBarTrailing) {

                    // Add Product
                    Button {
                        showAddProduct = true
                    } label: {
                        Image(systemName: "plus")
                    }

                    // Search 
                    NavigationLink(destination: SearchProductView()) {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }

            // Show Add Product 
            .sheet(isPresented: $showAddProduct) {
                AddProductView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }

    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                print("Error deleting: \(error.localizedDescription)")
            }
        }
    }
}
