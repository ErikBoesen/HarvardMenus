import Foundation
import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Header(text: "Settings")
            ScrollView {
                Paragraph(text: "Thanks for choosing Harvard Menus! This app was created by students who wanted a more user-friendly way to track menu items, allergens, and crowding in Harvard's dining halls.")
                Paragraph(text: "\"Harvard\" and \"Harvard University\" are registered trademarks of Harvard University. This application is maintained, hosted, and operated independently of Harvard University. The statements and information containd in this application are not reviewed, approved, or endorsed by Harvard.")
                Paragraph(text: "This app was built by Erik Boesen '24 and designed by David Foster '23.")
            }
        }.padding()
    }
}
