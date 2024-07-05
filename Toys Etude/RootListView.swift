//
//  RootListView.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2023/12/09.
//

import SwiftUI

struct RootListView: View {
    var body: some View {
        List {
            NavigationLink(destination: DiffableDataSourcePageViewControllerRepresentable()) {
                Text("DiffableDataSourcePageViewController")
            }
            NavigationLink(destination: DataSourcePageViewControllerRepresentable()) {
                Text("DataSourcePageViewController")
            }
            NavigationLink(destination: AccessControlViewControllerRepresentable()) {
                Text("AccessControlViewController")
            }
            NavigationLink(destination: CustomOperatorView()) {
                Text("CustomOperator")
            }
            NavigationLink(destination: SubscriptsView()) {
                Text("SubscriptsView")
            }
            NavigationLink(destination: ResultBuilderView()) {
                Text("ResultBuilderView")
            }
            NavigationLink(destination: PatternMatchingView()) {
                Text("PatternMatchingView")
            }
            NavigationLink(destination: ErrorHandlingView()) {
                Text("ErrorHandlingView")
            }
            NavigationLink(destination: DecodableView()) {
                Text("DecodableView")
            }
            NavigationLink(destination: MemoryManagementView()) {
                Text("MemoryManagementView")
            }
            NavigationLink(destination: ValueSemanticsView()) {
                Text("ValueSemanticsView")
            }
        }
    }
}
