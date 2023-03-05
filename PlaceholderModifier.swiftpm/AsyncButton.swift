//
//  AsyncButton.swift
//  Placeholder
//
//  Created by Eduard Caziuc on 05.03.2023.
//

import SwiftUI

struct AsyncButton<Label: View>: View {
	var role: ButtonRole? = nil
	var action: () async -> Void
	@ViewBuilder let label: () -> Label

	@MainActor
	@State private var isRunning = false

	var body: some View {
		Button(role: role) {
			isRunning = true
			Task {
				await action()
				isRunning = false
			}
		} label: {
			Group {
				if isRunning {
					ProgressView()
				} else {
					label()
						.font(.headline)
				}
			}
			.padding(.vertical, 8)
			.frame(maxWidth: .infinity)
		}
		.buttonStyle(.borderedProminent)
		.disabled(isRunning)
	}
}

extension AsyncButton where Label == Text {
	init(
		_ titleKey: LocalizedStringKey,
		role: ButtonRole? = nil,
		action: @escaping () async -> Void
	) {
		self.init(role: role, action: action) { Text(titleKey) }
	}
}


// MARK: - Preview

struct AsyncButton_Previews: PreviewProvider {
	static var previews: some View {
		AsyncButton("Async Task") {
			try? await Task.sleep(nanoseconds: 6_000_000_000)
		}
		.padding()
	}
}
