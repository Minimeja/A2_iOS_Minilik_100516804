import SwiftUI
import CoreData

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var productID = ""
    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productPrice = ""
    @State private var productProvider = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Product ID", text: $productID)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Product Name", text: $productName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Product Description", text: $productDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Product Price", text: $productPrice)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Product Provider", text: $productProvider)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            .padding(.vertical, 5)
            .navigationTitle("Add New Product")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save Product") {
                        saveProduct()
                    }
                }
            }
        }
    }

    private func saveProduct() {
        let newProduct = Product(context: viewContext)
        newProduct.productID = productID
        newProduct.productName = productName
        newProduct.productDescription = productDescription
        newProduct.productPrice = Double(productPrice) ?? 0.0
        newProduct.productProvider = productProvider

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Error saving product: \(error.localizedDescription)")
        }
    }
}
