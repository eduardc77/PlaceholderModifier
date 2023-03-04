import SwiftUI

struct ContentView: View {
	@State var placeholder: Bool = false
	
	var body: some View {
		ScrollView {
			VStack {
				VStack(alignment: .leading) {
					Text("Title 1").font(.title)
					Text(String(repeating: "Text ", count: 32))
					Rectangle().fill(.red)
						.frame(height: 60)
				}.placeholder(active: placeholder)

				VStack(alignment: .leading) {
					Text("Title 2").font(.title)
					Text(String(repeating: "Text ", count: 42))
					Rectangle().fill(.indigo)
						.frame(height: 60)
				}.placeholder(active: placeholder)

				VStack(alignment: .leading) {
					Text("Title 3").font(.title)
					Text(String(repeating: "Text ", count: 52))

					Rectangle().fill(.green)
						.frame(height: 60)

				}.placeholder(active: placeholder)
			}
			.padding(.horizontal)
		}
		.safeAreaInset(edge: .bottom) {
			Button(action: {
				Task {
					placeholder = true
					try? await Task.sleep(nanoseconds: 6_000_000_000)
					placeholder = false
				}
			}, label: {
				Text("Async Task")
					.frame(maxWidth: .infinity, maxHeight: 40)
			})
			.tint(.teal)
			.buttonStyle(.borderedProminent)
			.padding(.horizontal)
		}
	}
}
