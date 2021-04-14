import SwiftUI
import NavigationStack

struct Header: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    var text: String
    var location: Location?

    init(text: String, location: Location? = nil) {
        self.text = text
        self.location = location
    }

    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.faint)
                .frame(height: 25)
                .onTapGesture {
                    DispatchQueue.main.async {
                        self.navigationStack.pop()
                    }
                }
            Spacer()
            Text(self.text)
                .font(self.text.count <= 10 ? .appHeader : .appHeaderSmall)
                .foregroundColor(.main)
                .multilineTextAlignment(.trailing)
                // TODO: find a cleaner way to reduce padding
                .padding(.vertical, 5)
//            if (self.location != nil) {
//                Spacer()
//                Button(action: {
//                    self.navigationStack.push(LocationInfoView(location: self.location!))
//                }) {
//                    Image(systemName: "info.circle.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .foregroundColor(.light)
//                        .frame(height: 25)
//                }.buttonStyle(PlainButtonStyle())
//            }
        }
    }
}
